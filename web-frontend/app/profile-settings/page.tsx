"use client";
import React, { useState } from 'react';
import Sidebar from '@/components/common/Sidebar';
import Navbar from '@/components/common/Navbar';
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';

export default function ProfileSettingsPage() {
  // Address form state
  const [addressForm, setAddressForm] = useState({
    name: '',
    country: '',
    city: '',
    phone: '',
    address: '',
  });
  const [addressStatus, setAddressStatus] = useState<'idle' | 'success' | 'error'>('idle');
  const [addressMessage, setAddressMessage] = useState('');

  const handleAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setAddressForm({ ...addressForm, [e.target.name]: e.target.value });
  };

  const handleAddressSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setAddressStatus('idle');
    setAddressMessage('');
    try {
      // Adjust the endpoint as needed
      const token = localStorage.getItem('token');
      const res = await fetch('/api/user/address', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify(addressForm),
      });
      if (!res.ok) throw new Error('Failed to update address');
      setAddressStatus('success');
      setAddressMessage('Address updated successfully!');
    } catch (err) {
      setAddressStatus('error');
      setAddressMessage('Failed to update address.');
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <Sidebar />
      <div className="ml-64">
        <Navbar />
        <div className="pt-20 flex justify-start pl-32">
          <div className="w-full max-w-lg mt-8">
            <Tabs defaultValue="address" className="w-full">
              <TabsList className="w-full flex justify-start mb-8 bg-gray-100 rounded-full p-1">
                <TabsTrigger value="profile" className="rounded-full px-6 py-2 text-base data-[state=active]:bg-white data-[state=active]:text-teal-700 data-[state=active]:shadow-sm font-semibold transition-colors">Update Profile</TabsTrigger>
                <TabsTrigger value="address" className="rounded-full px-6 py-2 text-base data-[state=active]:bg-white data-[state=active]:text-teal-700 data-[state=active]:shadow-sm font-semibold transition-colors">Update Address</TabsTrigger>
              </TabsList>
              <TabsContent value="profile">
                <form className="space-y-8">
                  <div>
                    <label className="block text-sm font-medium mb-2">Name</label>
                    <input type="text" className="w-full bg-gray-50 rounded-xl px-3 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 placeholder:text-gray-400" placeholder="Your name..." />
                  </div>
                  <div>
                    <label className="block text-sm font-medium mb-2">Email</label>
                    <input type="email" className="w-full bg-gray-50 rounded-xl px-3 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 placeholder:text-gray-400" placeholder="Your email..." />
                  </div>
                  <div>
                    <label className="block text-sm font-medium mb-2">Profile Image</label>
                    <input type="file" className="w-full" />
                  </div>
                  <button type="submit" className="w-full bg-teal-700 text-white py-3 rounded-full text-lg font-semibold mt-8">Save Changes</button>
                </form>
              </TabsContent>
              <TabsContent value="address">
                <form className="space-y-8" onSubmit={handleAddressSubmit}>
                  <div>
                    <label className="block text-base font-medium mb-2">Country</label>
                    <input
                      type="text"
                      name="country"
                      className="w-full bg-gray-50 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 text-base placeholder:text-gray-400"
                      placeholder="Your country..."
                      value={addressForm.country}
                      onChange={handleAddressChange}
                    />
                  </div>
                  <div>
                    <label className="block text-base font-medium mb-2">City</label>
                    <input
                      type="text"
                      name="city"
                      className="w-full bg-gray-50 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 text-base placeholder:text-gray-400"
                      placeholder="Your city..."
                      value={addressForm.city}
                      onChange={handleAddressChange}
                    />
                  </div>
                  <div>
                    <label className="block text-base font-medium mb-2">Phone Number</label>
                    <input
                      type="text"
                      name="phone"
                      className="w-full bg-gray-50 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 text-base placeholder:text-gray-400"
                      placeholder="Your phone number..."
                      value={addressForm.phone}
                      onChange={handleAddressChange}
                    />
                  </div>
                  <div>
                    <label className="block text-base font-medium mb-2">Address</label>
                    <input
                      type="text"
                      name="address"
                      className="w-full bg-gray-50 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-teal-200 text-base placeholder:text-gray-400"
                      placeholder="Your address..."
                      value={addressForm.address}
                      onChange={handleAddressChange}
                    />
                  </div>
                  <button type="submit" className="w-full bg-teal-700 text-white py-3 rounded-full text-lg font-semibold mt-8 mb-8">Save Address</button>
                  {addressStatus === 'success' && (
                    <div className="text-green-600 text-center font-medium">{addressMessage}</div>
                  )}
                  {addressStatus === 'error' && (
                    <div className="text-red-600 text-center font-medium">{addressMessage}</div>
                  )}
                </form>
              </TabsContent>
            </Tabs>
          </div>
        </div>
      </div>
    </div>
  );
} 