"use client"
import { useState } from "react";
import { FaGoogle, FaFacebook } from "react-icons/fa";
import SelectRole from "../../../components/selectRole";

export default function SignIn() {
  const [isRoleSelection, setIsRoleSelection] = useState(false);
  const [formData, setFormData] = useState({ name: "", email: "", password: "" });

  const handleSubmit = (e) => {
    e.preventDefault();
    setIsRoleSelection(true);
  };



  return (
    <div className="min-h-screen flex bg-white">
      {/* Left Section */}
      <div className="w-3/5 flex flex-col justify-center items-center px-8">
        {isRoleSelection ? (
          <SelectRole formData={formData} />
        ) : (
          <>
            <div className="mb-5">
              <img src="/AfroV.svg" alt="Afro Vintage Logo" className="w-32 h-32" />
            </div>
            <form
              className="w-full max-w-sm"
              onSubmit={(e) => {
                handleSubmit(e);
                setFormData({
                  name: e.target.name.value,
                  email: e.target.email.value,
                  password: e.target.password.value,
                });
              }}
            >
              <div className="mb-4">
                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="name">
                  Name
                </label>
                <input
                  id="name"
                  type="text"
                  placeholder="Your Name"
                  className="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-teal-700"
                />
              </div>
              <div className="mb-4">
                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="email">
                  Email
                </label>
                <input
                  id="email"
                  type="email"
                  placeholder="Yourname@gmail.com"
                  className="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-teal-700"
                />
              </div>
              <div className="mb-4">
                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="password">
                  Password
                </label>
                <input
                  id="password"
                  type="password"
                  placeholder="Yourpassword"
                  className="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-teal-700"
                />
              </div>
              <button
                type="submit"
                className="w-full bg-teal-700 text-white py-2 rounded hover:bg-teal-800"
              >
                Sign up
              </button>
            </form>
            <p className="text-sm text-gray-600 mt-4">
              Already have an account? <a href="/auth/login" className="text-teal-700 font-bold">Sign in</a>
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
          </>
        )}
      </div>

      {/* Right Section */}
      <div className="flex-none hidden md:flex items-center justify-end bg-gray-100 m-0 p-0 w-auto fixed top-0 right-0 h-screen">
        <img
          src="/auth-page-img.png"
          alt="Afro Vintage Sign Up"
          className="rounded-lg shadow-md object-cover h-full"
        />
      </div>
    </div>
  );
}
