'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Image from 'next/image';
import { authApi } from '@/lib/api/auth';

interface SignupData {
  email: string;
  password: string;
  username: string;
}

const getRoleBasedRedirect = (role: string) => {
  switch (role.toLowerCase()) {
    case 'consumer':
      return '/consumer/marketplace';
    case 'supplier':
      return '/supplier/dashboard';
    case 'reseller':
      return '/reseller/dashboard';
    default:
      return '/dashboard';
  }
};

export default function SelectRolePage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [storedData, setStoredData] = useState<SignupData | null>(null);

  useEffect(() => {
    // Check if we have pending signup data
    const pendingSignup = sessionStorage.getItem('pendingSignup');
    if (!pendingSignup) {
      router.push('auth/signup');
      return;
    }
    setStoredData(JSON.parse(pendingSignup));
  }, [router]);

  const handleRoleSelect = async (role: 'consumer' | 'supplier' | 'reseller') => {
    if (!storedData) return;

    setLoading(true);
    setError(null);

    try {
      const response = await authApi.signup({
        ...storedData,
        role,
      });

      if (response.token) {
        // Clear stored data
        sessionStorage.removeItem('pendingSignup');
        
        // Store token and user data
        localStorage.setItem('token', response.token);
        localStorage.setItem('user', JSON.stringify(response.user));
        
        // Redirect based on role
        router.push(getRoleBasedRedirect(role));
      }
    } catch (err) {
      setError('Failed to create account. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (!storedData) {
    return null;
  }

  return (
    <div className="min-h-screen flex flex-col items-center px-4 py-12">
      <div className="w-full max-w-4xl">
        <Image
          src="/images/logo.png"
          alt="Afro Vintage Logo"
          width={200}
          height={80}
          className="mb-12 mx-auto"
        />
        
        <h1 className="text-4xl font-bold text-[#006D5B] text-center mb-12">
          Select Your Role
        </h1>

        {error && (
          <div className="mb-8 bg-red-50 border border-red-400 text-red-700 px-4 py-3 rounded relative text-center">
            {error}
          </div>
        )}

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Supplier Card */}
          <button
            onClick={() => handleRoleSelect('supplier')}
            disabled={loading}
            className="block w-full text-left"
          >
            <div className="border-2 border-[#006D5B] rounded-lg p-8 text-center hover:bg-[#006D5B] hover:text-white transition-colors">
              <div className="flex justify-center mb-6">
                <Image
                  src="/images/supplier-icon.png"
                  alt="Supplier"
                  width={64}
                  height={64}
                />
              </div>
              <h2 className="text-xl font-semibold mb-4">Supplier</h2>
              <p className="text-sm">
                Sell your products directly on AfroVintage
              </p>
            </div>
          </button>

          {/* Reseller Card */}
          <button
            onClick={() => handleRoleSelect('reseller')}
            disabled={loading}
            className="block w-full text-left"
          >
            <div className="border-2 border-[#006D5B] rounded-lg p-8 text-center hover:bg-[#006D5B] hover:text-white transition-colors">
              <div className="flex justify-center mb-6">
                <Image
                  src="/images/reseller-icon.png"
                  alt="Reseller"
                  width={64}
                  height={64}
                />
              </div>
              <h2 className="text-xl font-semibold mb-4">Reseller</h2>
              <p className="text-sm">
                Buy in bulk and resell with ease
              </p>
            </div>
          </button>

          {/* Consumer Card */}
          <button
            onClick={() => handleRoleSelect('consumer')}
            disabled={loading}
            className="block w-full text-left"
          >
            <div className="border-2 border-[#006D5B] rounded-lg p-8 text-center hover:bg-[#006D5B] hover:text-white transition-colors">
              <div className="flex justify-center mb-6">
                <Image
                  src="/images/consumer-icon.png"
                  alt="Consumer"
                  width={64}
                  height={64}
                />
              </div>
              <h2 className="text-xl font-semibold mb-4">Consumer</h2>
              <p className="text-sm">
                Explore and shop Afro-inspired products
              </p>
            </div>
          </button>
        </div>
      </div>
    </div>
  );
}