import React from "react";

interface Order {
  orderId: string;
  orderNumber: string;
  status: string;
  customerName: string;
  trackingCode: string;
}

const OrderTable: React.FC = () => {
  const orders: Order[] = [
    {
      orderId: "59217",
      orderNumber: "59217342",
      status: "[New order]",
      customerName: "Coqty Fisher",
      trackingCode: "940010010936113003113",
    },
    {
      orderId: "59213",
      orderNumber: "59217343",
      status: "[Imposterism]",
      customerName: "Kristin Watson",
      trackingCode: "940010010936113003113",
    },
    {
      orderId: "59219",
      orderNumber: "59217344",
      status: "[Shipped]",
      customerName: "Esther Howard",
      trackingCode: "940010010936113003113",
    },
    {
      orderId: "59220",
      orderNumber: "59217345",
      status: "[Canceled]",
      customerName: "Jenny Wilson",
      trackingCode: "940010010936113003113",
    },
    {
      orderId: "59223",
      orderNumber: "59217346",
      status: "[Rejected]",
      customerName: "John Smith",
      trackingCode: "940010010936113003113",
    },
    // Repeated entries for Cameron Williamson
    ...Array(5).fill({
      orderId: "592182",
      orderNumber: "59217346",
      status: "[Draft]",
      customerName: "Cameron Williamson",
      trackingCode: "940010010936113003113",
    }),
  ];

  return (
    <div className="p-4">
      <h1 className="text-xl font-bold mb-4"># Order</h1>
      <table className="w-full table-auto">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              ORDER ID
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              ORDER NUMBER
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              STATUS
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              CUSTOMER NAME
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              TRACKING CODE
            </th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {orders.map((order, index) => (
            <tr key={index}>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {order.orderId}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {order.orderNumber}
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="px-2.5 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                  {order.status}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {order.customerName}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900 font-mono">
                {order.trackingCode}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default OrderTable;
