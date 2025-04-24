'use client';

import React, { createContext, useContext, useState, useEffect } from 'react';
import { Notification, NotificationPreferences } from '@/types/notifications';
import { useRouter } from 'next/navigation';

interface NotificationContextType {
  notifications: Notification[];
  preferences: NotificationPreferences;
  unreadCount: number;
  markAsRead: (id: string) => void;
  updatePreferences: (prefs: NotificationPreferences) => void;
  handleNotificationClick: (notification: Notification) => void;
}

const NotificationContext = createContext<NotificationContextType | undefined>(undefined);

export function NotificationProvider({ children }: { children: React.ReactNode }) {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [preferences, setPreferences] = useState<NotificationPreferences>({
    inApp: true,
    email: false,
  });
  const router = useRouter();

  useEffect(() => {
    // Fetch initial notifications and preferences
    fetchNotifications();
    fetchPreferences();

    // Set up WebSocket or polling for real-time updates
    const ws = new WebSocket('ws://localhost:3000/ws/notifications');
    
    ws.onmessage = (event) => {
      const notification = JSON.parse(event.data);
      if (preferences.inApp) {
        setNotifications(prev => [notification, ...prev]);
      }
    };

    return () => ws.close();
  }, [preferences.inApp]);

  const fetchNotifications = async () => {
    try {
      const response = await fetch('/api/notifications');
      const data = await response.json();
      setNotifications(data);
    } catch (error) {
      console.error('Error fetching notifications:', error);
    }
  };

  const fetchPreferences = async () => {
    try {
      const response = await fetch('/api/notifications/preferences');
      const data = await response.json();
      setPreferences(data);
    } catch (error) {
      console.error('Error fetching preferences:', error);
    }
  };

  const markAsRead = async (id: string) => {
    try {
      await fetch(`/api/notifications/${id}/read`, { method: 'POST' });
      setNotifications(prev => 
        prev.map(n => n.id === id ? { ...n, read: true } : n)
      );
    } catch (error) {
      console.error('Error marking notification as read:', error);
    }
  };

  const updatePreferences = async (prefs: NotificationPreferences) => {
    try {
      await fetch('/api/notifications/preferences', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(prefs),
      });
      setPreferences(prefs);
    } catch (error) {
      console.error('Error updating preferences:', error);
    }
  };

  const handleNotificationClick = (notification: Notification) => {
    markAsRead(notification.id);
    if (notification.orderId) {
      router.push(`/consumer/orders/${notification.orderId}`);
    }
  };

  const unreadCount = notifications.filter(n => !n.read).length;

  return (
    <NotificationContext.Provider
      value={{
        notifications,
        preferences,
        unreadCount,
        markAsRead,
        updatePreferences,
        handleNotificationClick,
      }}
    >
      {children}
    </NotificationContext.Provider>
  );
}

export function useNotifications() {
  const context = useContext(NotificationContext);
  if (context === undefined) {
    throw new Error('useNotifications must be used within a NotificationProvider');
  }
  return context;
} 