// import { redirect } from "next/navigation";

// export default function Home() {
//   redirect("/signup");
// }

"use client";
import Image from "next/image";
import { FaUsers, FaGlobe, FaExchangeAlt, FaDollarSign } from "react-icons/fa";
import { useRouter } from "next/navigation";
import { Link } from "lucide-react";

export default function Home() {
  const router = useRouter();

  // const handleChoice = () => {
  //   router.push("/auth/login");
  // };

  const handleChoice = (choice: string) => {
    if (choice === "login") {
      router.push("auth/login");
      // After successful login
    } else if (choice === "Sign up") {
      router.push("auth/signup"); // After logout
    }
  };
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header Section */}
      <header className="bg-white shadow-md">
        <div className="container mx-auto flex justify-between items-center py-4 px-6">
          <div className="flex items-center gap-2">
            <Image
              src="/images/logo.png"
              alt="Afro Vintage Logo"
              width={100}
              height={100}
            />
          </div>
          <nav className="flex gap-4">
            <a className="text-gray-700 hover:text-teal-700">Home</a>
            <a href="#" className="text-gray-700 hover:text-teal-700">
              Service
            </a>
            <a href="#" className="text-gray-700 hover:text-teal-700">
              Feature
            </a>
            <a href="#" className="text-gray-700 hover:text-teal-700">
              Product
            </a>
            <a href="#" className="text-gray-700 hover:text-teal-700">
              Testimonial
            </a>
            <a href="#" className="text-gray-700 hover:text-teal-700">
              FAQ
            </a>
          </nav>
          <div className="flex gap-4">
            <button
              onClick={() => handleChoice("login")}
              className="text-teal-700  px-4 py-2 rounded"
            >
              Login
            </button>
            <button
              onClick={() => handleChoice("Sign up")}
              className="bg-teal-700 text-white px-4 py-2 rounded"
            >
              Sign up
            </button>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="w-full flex flex-col md:flex-row items-center justify-between py-16 px-12 hero-section">
        <div className="text-center md:text-left md:w-1/2 px-8">
          <h2 className="text-7xl font-bold text-gray-800 mb-4">
            Welcome to <span className="text-teal-700">Afro Vintage</span>
          </h2>
          <p className="text-gray-600 mb-6">
            Your ideal destination for unique, sustainable, and budget-friendly
            fashion.
          </p>
          <button className="bg-teal-700 text-white px-6 py-3 rounded">
            Register
          </button>
        </div>
        <div className="mt-8 md:mt-0 md:w-1/2 flex justify-center">
          <Image
            src="/images/hero-dress.png"
            alt="Afro Vintage Hero"
            width={300}
            height={300}
            className="rounded-lg shadow-md"
          />
        </div>
      </section>

      {/* Clients Section */}
      <section className="bg-gray-200 py-12">
        <div className="container mx-auto text-center">
          <h3 className="text-2xl font-bold text-gray-800 mb-6">Our Clients</h3>
          <p className="text-gray-600 mb-8">
            We have been working with Fortune 500+ clients
          </p>
          <div className="flex justify-center">
            <Image
              src="/images/Clients-Logos.png"
              alt="Clients Logos"
              width={1200}
              height={600}
            />
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="container mx-auto py-16 px-6">
        <h3 className="text-2xl font-bold text-gray-800 text-center mb-8">
          Manage the entire community in a single system
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="text-center">
            <Image
              src="/images/role1.svg"
              alt="Supplier"
              width={50}
              height={50}
              className="mx-auto"
            />
            <h4 className="text-xl font-bold text-gray-800 mt-4">Supplier</h4>
            <p className="text-gray-600">
              Upload bulk bundles, trade with suppliers, and connect with
              African resellers.
            </p>
          </div>
          <div className="text-center">
            <Image
              src="/images/role2.svg"
              alt="Reseller"
              width={50}
              height={50}
              className="mx-auto"
            />
            <h4 className="text-xl font-bold text-gray-800 mt-4">Reseller</h4>
            <p className="text-gray-600">
              Purchase bulk bundles, unpack items to sell individually, and
              manage your warehouses.
            </p>
          </div>
          <div className="text-center">
            <Image
              src="/images/role3.svg"
              alt="Consumer"
              width={50}
              height={50}
              className="mx-auto"
            />
            <h4 className="text-xl font-bold text-gray-800 mt-4">Consumer</h4>
            <p className="text-gray-600">
              Discover unique vintage and second-hand fashion items directly
              from resellers.
            </p>
          </div>
        </div>
      </section>

      {/* Empowering Africa Section */}
      <section className="container mx-auto flex flex-col md:flex-row items-center justify-between py-16 px-6">
        <div className="md:w-1/2 flex justify-center">
          <Image
            src="/images/hero-dress.png"
            alt="Empowering Africa"
            width={300}
            height={300}
            className="rounded-lg shadow-md"
          />
        </div>
        <div className="text-center md:text-left md:w-1/2 px-8">
          <h3 className="text-2xl font-bold text-gray-800 mb-4">
            Empowering Africa Through Sustainable Fashion
          </h3>
          <p className="text-gray-600 mb-6">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit
            amet justo ipsum. Sed accumsan quam vitae est varius fringilla.
            Pellentesque placerat vestibulum lorem.
          </p>
          <button className="bg-teal-700 text-white px-6 py-3 rounded">
            Learn More
          </button>
        </div>
      </section>

      {/* Helping Local Business Section */}
      <section className="bg-gray-100 py-12">
        <div className="container mx-auto flex flex-col md:flex-row items-center justify-between px-12">
          <div className="md:w-1/2 mb-8 md:mb-0">
            <h3 className="text-2xl font-bold text-teal-700 mb-4">
              Helping a local business reinvent itself
            </h3>
            <p className="text-gray-600">
              We reached here with our hard work and dedication
            </p>
          </div>
          <div className="md:w-1/2 grid grid-cols-2 gap-6">
            <div className="text-center">
              <FaUsers size={40} className="mx-auto mb-2 text-teal-700" />
              <p className="text-xl font-bold text-gray-800">12,438</p>
              <p className="text-gray-600">Registered Sellers</p>
            </div>
            <div className="text-center">
              <FaGlobe size={40} className="mx-auto mb-2 text-teal-700" />
              <p className="text-xl font-bold text-gray-800">34,782</p>
              <p className="text-gray-600">Pre-owned Items Listed</p>
            </div>
            <div className="text-center">
              <FaExchangeAlt size={40} className="mx-auto mb-2 text-teal-700" />
              <p className="text-xl font-bold text-gray-800">7,529</p>
              <p className="text-gray-600">Successful Transactions</p>
            </div>
            <div className="text-center">
              <FaDollarSign size={40} className="mx-auto mb-2 text-teal-700" />
              <p className="text-xl font-bold text-gray-800">$182,760</p>
              <p className="text-gray-600">Money Circulated Locally</p>
            </div>
          </div>
        </div>
      </section>

      {/* Sponsors Section */}
      <section className="container mx-auto py-16 px-30">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 items-center">
          <div>
            <Image
              src="/images/hero-dress.png"
              alt="Fashion Marketplace"
              width={300}
              height={300}
              className="rounded-lg shadow-md ml-20"
            />
          </div>
          <div>
            <h3 className="text-2xl font-bold text-gray-800 mb-4">
              Africa’s Premier Pre-Owned Fashion Marketplace
            </h3>
            <p className="text-gray-600 mb-6">
              Donec a eros justo. Fusce egestas tristique risus. Nam tempor,
              augue nec tincidunt malesuada, massa nunc vehicula est, eu
              bibendum elit erat eget magna. Donec pellentesque at nisi nec
              tristique. In hac habitasse platea dictumst. Vivamus vehicula dui
              vel orci porta tincidunt. Proin in felis nec tortor posuere
              ultrices. Praesent sit amet lacus, suscipit est ac, hendrerit
              venenatis lorem. Donec consectetur facilisis ipsum id gravida.
            </p>
            <button className="bg-teal-700 text-white px-6 py-3 rounded">
              Learn More
            </button>
          </div>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 items-center mt-16">
          <div>
            <Image
              src="/images/hero-dress.png"
              alt="Sponsor Logo"
              width={300}
              height={300}
              className="rounded-lg shadow-md ml-20"
            />
          </div>
          <div>
            <p className="text-gray-600 mb-6">
              Maecenas dignissim justo eget nulla rutrum molestie. Maecenas
              lobortis sem dui, vel rutrum risus tincidunt ullamcorper. Proin eu
              mattis metus. Vivamus lobortis orci id justo posuere, tristique
              euismod mi gravida. Nam ut malesuada arcu, et hendrerit arcu.
              Aenean bibendum velit sit amet ligula malesuada, nec malesuada mi
              blandit. Suspendisse eu cursus nulla sed augue efficitur, quis
              tincidunt nulla sodales. Suspendisse eu lorem eu turpis vestibulum
              pretium. Suspendisse potenti. Quisque malesuada enim at imperdiet.
              Ut placerat diam eget feugiat euismod. Quisque volutpat odio eget,
              egestas felis condimentum id. Curabitur in nisl sem dignissim
              finibus sit amet eget magna.
            </p>
            <p className="text-gray-800 font-bold">Tim Smith</p>
            <p className="text-gray-600">
              British Dragon Boat Racing Association
            </p>
            <div className="flex items-center gap-4 mt-4">
              <Image src="/images/file.svg" alt="File Icon" width={24} height={24} />
              <Image src="/images/globe.svg" alt="Globe Icon" width={24} height={24} />
              <Image
                src="/images/window.svg"
                alt="Window Icon"
                width={24}
                height={24}
              />
              <Image src="/images/next.svg" alt="Next Icon" width={24} height={24} />
              <a href="#" className="text-teal-700 font-bold">
                Meet all Sponsors
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* Current Marketplace Listings Section */}
      <section className="container mx-auto py-16 px-24">
        <h3 className="text-2xl font-bold text-gray-800 text-center mb-4">
          Current Marketplace Listings
        </h3>
        <p className="text-gray-600 text-center mb-8">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet
          justo ipsum. Sed accumsan quam vitae est varius fringilla.
          Pellentesque placerat vestibulum lorem.
        </p>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="bg-white shadow-md rounded-lg p-4 text-center">
            <Image
              src="/images/hero-dress.png"
              alt="Product 1"
              width={200}
              height={200}
              className="mx-auto"
            />
            <h4 className="text-lg font-bold text-gray-800 mt-4">
              Product Name
            </h4>
            <p className="text-teal-700 font-bold mt-2">$399</p>
          </div>
          <div className="bg-white shadow-md rounded-lg p-4 text-center">
            <Image
              src="/images/dress2.png"
              alt="Product 2"
              width={200}
              height={200}
              className="mx-auto"
            />
            <h4 className="text-lg font-bold text-gray-800 mt-4">
              Product Name
            </h4>
            <p className="text-teal-700 font-bold mt-2">$399</p>
          </div>
          <div className="hero-dress-white shadow-md rounded-lg p-4 text-center">
            <Image
              src="/images/hero-dress.png"
              alt="Product 3"
              width={200}
              height={200}
              className="mx-auto"
            />
            <h4 className="text-lg font-bold text-gray-800 mt-4">
              Product Name
            </h4>
            <p className="text-teal-700 font-bold mt-2">$399</p>
          </div>
        </div>
      </section>

      {/* Footer Section */}
      <footer className="bg-teal-700 text-white py-8 px-18">
        <div className="container mx-auto grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <h3 className="text-lg font-bold mb-4">Afro Vintage</h3>
            <p className="text-sm">Copyright © 2020 Afro Vintage</p>
            <p className="text-sm">All rights reserved</p>
          </div>
          <div>
            <h4 className="text-md font-bold mb-2">Company</h4>
            <ul className="space-y-1">
              <li>
                <a href="#" className="hover:underline text-sm">
                  About us
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Blog
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Contact us
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Pricing
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Testimonials
                </a>
              </li>
            </ul>
          </div>
          <div>
            <h4 className="text-md font-bold mb-2">Support</h4>
            <ul className="space-y-1">
              <li>
                <a href="#" className="hover:underline text-sm">
                  Help center
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Terms of service
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Legal
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Privacy policy
                </a>
              </li>
              <li>
                <a href="#" className="hover:underline text-sm">
                  Status
                </a>
              </li>
            </ul>
          </div>
          <div>
            <h4 className="text-md font-bold mb-2">Stay up to date</h4>
            <div className="flex items-center border border-white rounded-md overflow-hidden">
              <input
                type="email"
                placeholder="Your email address"
                className="flex-grow px-4 py-2 text-black placeholder-white placeholder-opacity-50"
              />
              <button className="bg-white text-teal-700 pr-5 pl-2 py-2 text-center">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth="1.5"
                  stroke="currentColor"
                  className="w-6 h-6"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M17.25 8.75L21 12m0 0l-3.75 3.25M21 12H3"
                  />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
