"use client";

import { FaGoogle, FaFacebook } from "react-icons/fa";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { loginUser } from "@/utils/api";

export default function SignIn() {
  const router = useRouter();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    const token = sessionStorage.getItem("authToken");
    if (token) {
      router.push("/dashboard");
    }
  }, [router]);

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const { token } = await loginUser(username, password);
      if (token) {
        sessionStorage.setItem("authToken", token);
        router.push("/dashboard");
      } else {
        setError("Login failed. Please try again.");
      }
    } catch (err) {
      setError("Invalid username or password. Please try again.");
    }
  };

  return (
    <div className="min-h-screen flex bg-white">
      {/* Left Section */}
      <div className="flex-none hidden md:flex items-center justify-center bg-gray-100">
        <img
          src="/auth-page-img.png"
          alt="Afro Vintage Sign In"
          className="rounded-lg shadow-md object-cover h-screen"
        />
      </div>

      {/* Right Section */}
      <div className="w-full md:w-1/2 flex flex-col justify-center items-center px-8">
        <div className="mb-8">
          <img src="/AfroV.svg" alt="Afro Vintage Logo" className="w-32 h-32" />
        </div>
        <form className="w-full max-w-sm" onSubmit={handleLogin}>
          <div className="mb-4">
            <label
              className="block text-gray-700 text-sm font-bold mb-2"
              htmlFor="username"
            >
              Username
            </label>
            <input
              id="username"
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="Your username"
              className="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-teal-700"
            />
          </div>
          <div className="mb-4">
            <label
              className="block text-gray-700 text-sm font-bold mb-2"
              htmlFor="password"
            >
              Password
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Your password"
              className="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-teal-700"
            />
          </div>
          {error && <p className="text-red-500 text-sm mb-4">{error}</p>}
          <button
            type="submit"
            className="w-full bg-teal-700 text-white py-2 rounded hover:bg-teal-800"
          >
            Sign in
          </button>
        </form>
        <p className="text-sm text-gray-600 mt-4">
          Don’t have an account?{" "}
          <a href="/auth/signup" className="text-teal-700 font-bold">
            Sign Up
          </a>
        </p>
        <div className="flex items-center my-4">
          <hr className="flex-grow border-gray-300" />
          <span className="mx-2 text-gray-500 text-xs">Or Sign in with</span>
          <hr className="flex-grow border-gray-300" />
        </div>
        <div className="flex gap-4">
          <button className="flex items-center gap-2 px-4 py-2 border rounded hover:bg-gray-100">
            <FaGoogle className="text-red-500" />{" "}
            <span className="text-[#5d4153]">Google</span>
          </button>
          <button className="flex items-center gap-2 px-4 py-2 border rounded hover:bg-gray-100">
            <FaFacebook className="text-blue-500" />{" "}
            <span className="text-[#5d4153]">Facebook</span>
          </button>
        </div>
        <p className="text-xs text-gray-500 mt-4 text-center">
          By registering you agree with our{" "}
          <a href="/terms" className="text-teal-700">
            Terms and Conditions
          </a>
        </p>
      </div>
    </div>
  );
}
