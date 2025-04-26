import { FaRegEdit } from "react-icons/fa";

const OrdersTable = () => {
  const orders = [
    {
      id: "59217",
      number: "59217342",
      status: "New order",
      customer: "Cody Fisher",
      tracking: "940010010936113003113",
    },
    {
      id: "59213",
      number: "59217343",
      status: "Inproduction",
      customer: "Kristin Watson",
      tracking: "940010010936113003113",
    },
    {
      id: "59219",
      number: "59217344",
      status: "Shipped",
      customer: "Esther Howard",
      tracking: "940010010936113003113",
    },
    {
      id: "59220",
      number: "59217345",
      status: "Cancelled",
      customer: "Jenny Wilson",
      tracking: "940010010936113003113",
    },
    {
      id: "59223",
      number: "59217346",
      status: "Rejected",
      customer: "John Smith",
      tracking: "940010010936113003113",
    },
    {
      id: "592182",
      number: "59217346",
      status: "Draft",
      customer: "Cameron Williamson",
      tracking: "940010010936113003113",
    },
    {
      id: "592182",
      number: "59217346",
      status: "Draft",
      customer: "Cameron Williamson",
      tracking: "940010010936113003113",
    },
    {
      id: "592182",
      number: "59217347",
      status: "Draft",
      customer: "Cameron Williamson",
      tracking: "940010010936113003113",
    },
    {
      id: "592182",
      number: "59217347",
      status: "Draft",
      customer: "Cameron Williamson",
      tracking: "940010010936113003113",
    },
    {
      id: "592182",
      number: "59217347",
      status: "Draft",
      customer: "Cameron Williamson",
      tracking: "940010010936113003113",
    },
  ];

  const statusColors: { [key: string]: string } = {
    "New order": "bg-blue-100 text-blue-600",
    Inproduction: "bg-yellow-100 text-yellow-600",
    Shipped: "bg-green-100 text-green-600",
    Cancelled: "bg-pink-100 text-pink-600",
    Rejected: "bg-red-100 text-red-600",
    Draft: "bg-gray-100 text-gray-600",
  };

  return (
    <div className="p-4 sm:p-8">
      {/* Heading */}
      <h2 className="text-2xl font-semibold text-teal-700 mb-6">Order</h2>

      {/* Table for Desktop */}
      <div className="hidden md:block overflow-x-auto rounded-lg bg-white shadow-md">
        <table className="min-w-full text-left text-[10px]">
          <thead className="bg-gray-50 text-gray-600 uppercase">
            <tr>
              <th className="py-3 px-4">Order ID</th>
              <th className="py-3 px-4">Order Number</th>
              <th className="py-3 px-4">Status</th>
              <th className="py-3 px-4">Customer Name</th>
              <th className="py-3 px-4">Tracking Code</th>
              <th className="py-3 px-4"></th>
            </tr>
          </thead>
          <tbody className="text-gray-700">
            {orders.map((order, index) => (
              <tr key={index} className="border-b hover:bg-gray-50">
                <td className="py-3 px-4">{order.id}</td>
                <td className="py-3 px-4">{order.number}</td>
                <td className="py-3 px-4">
                  <span
                    className={`px-2 py-1 rounded-full font-medium ${
                      statusColors[order.status]
                    } text-[10px]`}
                  >
                    {order.status}
                  </span>
                </td>
                <td className="py-3 px-4">{order.customer}</td>
                <td className="py-3 px-4">{order.tracking}</td>
                <td className="py-3 px-4 text-right">
                  <button className="text-gray-500 hover:text-gray-700">
                    <FaRegEdit className="w-3.5 h-3.5" />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Cards for Mobile */}
      <div className="md:hidden space-y-4">
        {orders.map((order, index) => (
          <div key={index} className="rounded-lg bg-white p-4 shadow-md">
            <div className="flex justify-between items-center mb-2">
              <span className="text-[10px] font-semibold text-gray-800">
                Order ID:
              </span>
              <span className="text-[10px] text-gray-500">{order.id}</span>
            </div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-[10px] font-semibold text-gray-800">
                Order Number:
              </span>
              <span className="text-[10px] text-gray-500">{order.number}</span>
            </div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-[10px] font-semibold text-gray-800">
                Status:
              </span>
              <span
                className={`px-2 py-1 rounded-full font-medium ${
                  statusColors[order.status]
                } text-[10px]`}
              >
                {order.status}
              </span>
            </div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-[10px] font-semibold text-gray-800">
                Customer Name:
              </span>
              <span className="text-[10px] text-gray-500">
                {order.customer}
              </span>
            </div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-[10px] font-semibold text-gray-800">
                Tracking Code:
              </span>
              <span className="text-[10px] text-gray-500">
                {order.tracking}
              </span>
            </div>
            <div className="flex justify-end">
              <button className="text-gray-500 hover:text-gray-700">
                <FaRegEdit className="w-4 h-4" />
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Pagination (Dummy) */}
      <div className="mt-4 flex flex-col sm:flex-row justify-between items-center text-[10px] space-y-2 sm:space-y-0">
        <span>Showing 1 to 10 of 97 results</span>
        <div className="flex space-x-1">
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            {"<"}
          </button>
          <button className="px-2 py-1 bg-blue-500 text-white border rounded">
            1
          </button>
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            2
          </button>
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            3
          </button>
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            ...
          </button>
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            10
          </button>
          <button className="px-2 py-1 bg-white border rounded hover:bg-gray-100">
            {">"}
          </button>
        </div>
      </div>
    </div>
  );
};

export default OrdersTable;
