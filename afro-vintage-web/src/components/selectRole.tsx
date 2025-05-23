import { useState } from "react";
import { useRouter } from "next/navigation";
import { registerUser } from "../utils/api";

export default function ChooseRole({ formData, setFormData }: { formData: { name: string; email: string; password: string }; setFormData: React.Dispatch<React.SetStateAction<{ name: string; email: string; password: string }>> }) {
  const [selectedRole, setSelectedRole] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  const handleRoleSelect = (role: string) => {
    setSelectedRole(role);
  };

  const handleSubmit = async () => {
    if (selectedRole) {
      try {
        const userData = {
          username: formData.name,
          email: formData.email,
          password: formData.password,
          role: selectedRole.toLowerCase(),
        };
        const response = await registerUser(userData);
        if (response.token) {
          sessionStorage.setItem("authToken", response.token); // Store the token in session storage
          router.push("/dashboard");
        } else {
          setError("Something is wrong. Please try again.");
        }
      } catch (error) {
        console.error("Failed to register user:", error);
        setError("Something is wrong. Please try again.");
      }
    }
  };

  return (
    <div className="min-h-screen flex bg-white">
      {/* Left Section */}
      <div className="w-[700px] flex flex-col justify-center items-center px-8">
        <div className="mb-5">
          <img src="/AfroV.svg" alt="Afro Vintage Logo" className="w-32 h-32" />
        </div>
        <h1 className="text-3xl font-bold text-teal-700 mb-6">Select Your Role</h1>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div
            className={`border rounded-lg p-6 text-center cursor-pointer ${
              selectedRole === "Supplier" ? "border-teal-700 bg-teal-700 text-white [&_*]:text-white [&>img]:filter [&>img]:brightness-0 [&>img]:invert" : "border-teal-700"
            }`}
            onClick={() => handleRoleSelect("Supplier")}
          >
            <img src="/role1.svg" alt="Supplier" className="mx-auto mb-4" />
            <h2 className="text-xl font-bold text-teal-700">Supplier</h2>
            <p className="text-gray-600">Sell your products directly on AfroVintage</p>
          </div>
          <div
            className={`border rounded-lg p-6 text-center cursor-pointer ${
              selectedRole === "Reseller" ? "border-teal-700 bg-teal-700 text-white [&_*]:text-white [&>img]:filter [&>img]:brightness-0 [&>img]:invert" : "border-teal-700"
            }`}
            onClick={() => handleRoleSelect("Reseller")}
          >
            <img src="/role2.svg" alt="Reseller" className="mx-auto mb-4" />
            <h2 className="text-xl font-bold text-teal-700">Reseller</h2>
            <p className="text-gray-600">Buy in bulk and resell with ease</p>
          </div>
          <div
            className={`border rounded-lg p-6 text-center cursor-pointer ${
              selectedRole === "Consumer" ? "border-teal-700 bg-teal-700 text-white [&_*]:text-white [&>img]:filter [&>img]:brightness-0 [&>img]:invert" : "border-teal-700"
            }`}
            onClick={() => handleRoleSelect("Consumer")}
          >
            <img src="/role3.svg" alt="Consumer" className="mx-auto mb-4" />
            <h2 className="text-xl font-bold text-teal-700">Consumer</h2>
            <p className="text-gray-600">Explore and shop Afro-Inspired products</p>
          </div>
        </div>
        {error && <p className="text-red-500 mt-4">{error}</p>}
        <div className="mt-6">
          <button
            className="w-full bg-teal-700 text-white py-2 px-4 rounded hover:bg-teal-800"
            disabled={!selectedRole}
            onClick={handleSubmit}
          >
            Submit
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
