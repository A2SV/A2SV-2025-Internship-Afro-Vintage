'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { AuthResponse, AuthError } from '@/types/auth';
import Link from 'next/link';
import Image from 'next/image';

interface SignupData {
  email: string;
  password: string;
  username: string;
}

export default function SignupForm() {
  const router = useRouter();
  const [formData, setFormData] = useState<SignupData>({
    email: '',
    password: '',
    username: '',
  });
  const [error, setError] = useState<AuthError | null>(null);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validate fields
    if (!formData.email || !formData.password || !formData.username) {
      setError({ message: 'All fields are required' });
      return;
    }

    // Basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      setError({ message: 'Please enter a valid email address' });
      return;
    }

    // Basic password validation
    if (formData.password.length < 6) {
      setError({ message: 'Password must be at least 6 characters long' });
      return;
    }

    // Username validation
    if (formData.username.length < 3) {
      setError({ message: 'Username must be at least 3 characters long' });
      return;
    }

    setLoading(true);
    setError(null);

    try {
      // Store credentials in sessionStorage temporarily
      sessionStorage.setItem('pendingSignup', JSON.stringify(formData));
      
      // Redirect to role selection
      router.push('/select-role');
    } catch (err) {
      setError({
        message: 'An unexpected error occurred. Please try again.',
      });
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData((prev) => ({
      ...prev,
      [e.target.name]: e.target.value,
    }));
  };

  return (
    <div className="flex h-screen">
      {/* Left side - Form */}
      <div className="w-full lg:w-1/2 flex flex-col justify-center p-8 lg:p-16">
        <div className="max-w-md w-full mx-auto space-y-8">
          <div className="flex flex-col items-center">
            <Image
              src="/images/logo.png"
              alt="Afro Vintage Logo"
              width={200}
              height={80}
              className="mb-12"
            />
            <h2 className="text-4xl font-bold text-[#006D5B] mb-12">SIGN UP</h2>
          </div>

          <form onSubmit={handleSubmit} className="space-y-8">
            {error && (
              <div className="bg-red-50 border border-red-400 text-red-700 px-4 py-3 rounded relative">
                {error.message}
              </div>
            )}

            <div className="space-y-4">
              <div>
                <input
                  id="username"
                  name="username"
                  type="text"
                  required
                  className="appearance-none rounded-lg relative block w-full px-4 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-[#006D5B] focus:border-[#006D5B] sm:text-sm"
                  placeholder="Username"
                  value={formData.username}
                  onChange={handleChange}
                />
              </div>
              <div>
                <input
                  id="email"
                  name="email"
                  type="email"
                  required
                  className="appearance-none rounded-lg relative block w-full px-4 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-[#006D5B] focus:border-[#006D5B] sm:text-sm"
                  placeholder="Yourname@gmail.com"
                  value={formData.email}
                  onChange={handleChange}
                />
              </div>
              <div>
                <input
                  id="password"
                  name="password"
                  type="password"
                  required
                  className="appearance-none rounded-lg relative block w-full px-4 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-[#006D5B] focus:border-[#006D5B] sm:text-sm"
                  placeholder="Yourpassword"
                  value={formData.password}
                  onChange={handleChange}
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg text-sm font-medium text-white bg-[#006D5B] hover:bg-[#005446] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#006D5B] disabled:opacity-50"
            >
              {loading ? 'Please wait...' : 'Sign up'}
            </button>

            <div className="text-center">
              <p className="text-sm text-gray-600">
                Already have an account?{' '}
                <Link href="auth/login" className="text-[#006D5B] hover:text-[#005446]">
                  Signin
                </Link>
              </p>
            </div>

            <div className="mt-6">
              <div className="relative">
                <div className="absolute inset-0 flex items-center">
                  <div className="w-full border-t border-gray-300"></div>
                </div>
                <div className="relative flex justify-center text-sm">
                  <span className="px-2 bg-white text-gray-500">Or Sign up with</span>
                </div>
              </div>

              <div className="mt-6 grid grid-cols-2 gap-3">
                <button
                  type="button"
                  className="w-full flex justify-center items-center px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50"
                >
                  <Image
                    src="/images/google.png"
                    alt="Google"
                    width={20}
                    height={20}
                    className="mr-2"
                  />
                  Google
                </button>
                <button
                  type="button"
                  className="w-full flex justify-center items-center px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50"
                >
                  <Image
                    src="/images/facebook.png"
                    alt="Facebook"
                    width={20}
                    height={20}
                    className="mr-2"
                  />
                  Facebook
                </button>
              </div>
            </div>

            <div className="text-center text-xs text-gray-600 mt-4">
              By registering you agree with our{' '}
              <Link href="/terms" className="text-[#006D5B] hover:text-[#005446]">
                Terms and Conditions
              </Link>
            </div>
          </form>
        </div>
      </div>

      {/* Right side - Image */}
      <div className="hidden lg:block lg:w-1/2">
        <Image
          src="/images/sign-in-image.png"
          alt="Afro Vintage Fashion"
          width={1000}
          height={1000}
          className="object-cover w-full h-full"
        />
      </div>
    </div>
  );
} 