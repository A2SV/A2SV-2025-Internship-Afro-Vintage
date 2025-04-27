'use client';

import React from 'react';
import { useNotifications } from '@/context/NotificationContext';

export default function NotificationPreferences() {
  const { preferences, updatePreferences } = useNotifications();

  const handleToggle = (key: keyof typeof preferences) => {
    updatePreferences({
      ...preferences,
      [key]: !preferences[key],
    });
  };

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-lg font-medium text-gray-900">Notification Settings</h3>
        <p className="mt-1 text-sm text-gray-500">
          Manage how you receive notifications
        </p>
      </div>

      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <h4 className="text-sm font-medium text-gray-900">In-app Notifications</h4>
            <p className="text-sm text-gray-500">
              Receive notifications within the application
            </p>
          </div>
          <button
            onClick={() => handleToggle('inApp')}
            className={`${
              preferences.inApp ? 'bg-blue-600' : 'bg-gray-200'
            } relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2`}
          >
            <span
              className={`${
                preferences.inApp ? 'translate-x-5' : 'translate-x-0'
              } pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out`}
            />
          </button>
        </div>

        <div className="flex items-center justify-between">
          <div>
            <h4 className="text-sm font-medium text-gray-900">Email Notifications</h4>
            <p className="text-sm text-gray-500">
              Receive notifications via email
            </p>
          </div>
          <button
            onClick={() => handleToggle('email')}
            className={`${
              preferences.email ? 'bg-blue-600' : 'bg-gray-200'
            } relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2`}
          >
            <span
              className={`${
                preferences.email ? 'translate-x-5' : 'translate-x-0'
              } pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out`}
            />
          </button>
        </div>
      </div>
    </div>
  );
} 