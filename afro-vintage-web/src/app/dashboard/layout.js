import '@fortawesome/fontawesome-free/css/all.min.css';
import '@fortawesome/fontawesome-free/css/regular.min.css';

export const metadata = {
  title: "Dashboard | Afro Vintage",
  description: "User dashboard for managing bundles and orders on Afro Vintage",
};

export default function DashboardLayout({ children }) {
  return (
    <div className="min-h-screen flex bg-gray-100">
      {/* Sidebar */}
      <aside className="w-1/5 bg-white shadow-md p-6 pl-10">
        <div className="mb-8">
          <img src="/AfroV-grad.png" alt="Afro Vintage Logo" className="mx-auto w-auto h-20" />
        </div>
        <nav className="space-y-6">
          <a href="#" className="flex items-center text-teal-700 font-bold">
            <i className="fas fa-th-large w-5 h-5 mr-2"></i> Dashboard
          </a>
          <a href="#" className="flex items-center text-gray-600 hover:text-teal-700">
            <i className="fas fa-box w-5 h-5 mr-2"></i> Add Bundle
          </a>
          <a href="#" className="flex items-center text-gray-600 hover:text-teal-700">
            <i className="fas fa-shopping-cart w-5 h-5 mr-2"></i> Orders
          </a>
          <a href="#" className="flex items-center text-gray-600 hover:text-teal-700">
            <i className="fas fa-users w-5 h-5 mr-2"></i> View Bundles
          </a>
          <a href="#" className="flex items-center text-gray-600 hover:text-teal-700">
            <i className="fas fa-star w-5 h-5 mr-2"></i> Reviews
          </a>
          <a href="#" className="flex items-center text-gray-600 hover:text-teal-700">
            <i className="fas fa-cog w-5 h-5 mr-2"></i> Settings
          </a>
        </nav>
        <div className="mt-8">
          <a href="#" className="flex items-center text-gray-600 hover:text-red-600">
            <i className="fas fa-sign-out-alt w-5 h-5 mr-2"></i> Log out
          </a>
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 p-6">
        {children}
      </main>
    </div>
  );
}