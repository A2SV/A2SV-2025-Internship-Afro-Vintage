'use client';

import { Dialog } from '@headlessui/react';
import { useEffect, useState } from 'react';
import axios from 'axios';
import { toast } from 'react-hot-toast';

interface ProfileSettingsModalProps {
  isOpen: boolean;
  onClose: () => void;
  user: {
    name?: string;
    username: string;
    email: string;
    image_url?: string;
  } | null;
}

export default function ProfileSettingsModal({ isOpen, onClose, user }: ProfileSettingsModalProps) {
  const [name, setName] = useState('');
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [imageUrl, setImageUrl] = useState('');
  const [file, setFile] = useState<File | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (user) {
      setName(user.name || '');
      setUsername(user.username || '');
      setEmail(user.email || '');
      setImageUrl(user.image_url || '');
    }
  }, [user]);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = e.target.files?.[0];
    if (selectedFile) {
      setFile(selectedFile);
      const previewURL = URL.createObjectURL(selectedFile);
      setImageUrl(previewURL);
    }
  };

  const uploadImage = async (): Promise<string> => {
    if (!file) return '';

    const formData = new FormData();
    formData.append('file', file);

    const res = await axios.post('http://localhost:8080/api/upload', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return res.data.image_url;
  };

  const handleSubmit = async () => {
    try {
      setLoading(true);
      setError('');
      const token = localStorage.getItem('token');
      if (!token) throw new Error('No token found');

      let uploadedImageUrl = imageUrl;
      if (file) {
        const uploaded = await uploadImage();
        uploadedImageUrl = uploaded || '';
      }

      const res = await axios.put(
        'http://localhost:8080/api/users/profile',
        { name, username, email, image_url: uploadedImageUrl },
        {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
        }
      );

      // Update localStorage with new user info
      const oldUser = localStorage.getItem('user');
      if (oldUser) {
        const parsed = JSON.parse(oldUser);
        const updatedUser = {
          ...parsed,
          name,
          username,
          email,
          image_url: uploadedImageUrl,
        };
        localStorage.setItem('user', JSON.stringify(updatedUser));
      }

      toast.success('✅ Profile updated successfully!');
      onClose();
    } catch (err: any) {
      console.error('❌ Error updating profile:', err);
      setError(err.response?.data?.message || err.message || 'Something went wrong');
      toast.error('❌ Failed to update profile');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={isOpen} onClose={onClose} className="fixed z-50 inset-0 overflow-y-auto">
      <div className="flex items-center justify-center min-h-screen">
        <div className="fixed inset-0 bg-black opacity-30" />
        <div className="relative bg-white rounded-lg p-6 w-full max-w-md mx-auto shadow-lg z-50">
          <Dialog.Title className="text-lg font-semibold mb-4 text-gray-800">
            Update Profile
          </Dialog.Title>

          <div className="space-y-4">
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Full Name"
              className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-teal-500 text-sm"
            />
            <input
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="Username"
              className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-teal-500 text-sm"
            />
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Email"
              className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-teal-500 text-sm"
            />

            <input
              type="file"
              accept="image/*"
              onChange={handleFileChange}
              className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:border-teal-500 text-sm"
            />

            {/* Image Preview */}
            {imageUrl && (
              <div className="mt-2">
                <img
                  src={imageUrl}
                  alt="Selected profile"
                  className="w-20 h-20 rounded-full object-cover mx-auto"
                />
              </div>
            )}
          </div>

          {error && (
            <div className="text-red-500 text-sm mt-2">{error}</div>
          )}

          <div className="mt-6 flex justify-end space-x-3">
            <button
              onClick={onClose}
              className="px-4 py-2 text-sm text-gray-600 border rounded-lg hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              onClick={handleSubmit}
              disabled={loading}
              className="px-4 py-2 bg-teal-600 text-white text-sm rounded-lg hover:bg-teal-700 disabled:opacity-50"
            >
              {loading ? 'Saving...' : 'Save'}
            </button>
          </div>
        </div>
      </div>
    </Dialog>
  );
}
