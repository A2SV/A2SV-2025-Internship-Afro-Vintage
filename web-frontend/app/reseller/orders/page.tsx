"use client";

import { useEffect, useState } from "react";
import { FaRegEdit } from "react-icons/fa";

type Order = {
  orderId: string;
  itemTitle: string;
  price: number;
  status: string;
  purchaseDate: string;
  estimatedDeliveryTime: string;
  imageUrl: string;
};

const statusColors: { [key: string]: string } = {
  delivered: "bg-green-100 text-green-600",
  pending: "bg-yellow-100 text-yellow-600",
  cancelled: "bg-pink-100 text-pink-600",
  rejected: "bg-red-100 text-red-600",
  draft: "bg-gray-100 text-gray-600",
};

export default function OrdersTable() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) throw new Error("No token found");
  
        const res = await fetch("http://localhost:8081/orders/history", {
          headers: { Authorization: `Bearer ${token}` },
        });
  
        if (!res.ok) throw new Error("Failed to fetch orders");
  
        const json = await res.json();
        console.log("📦 Full backend response:", json);
  
        if (Array.isArray(json.data)) {
          setOrders(json.data);
        } else {
          console.error("❌ Data is not an array:", json.data);
          setOrders([]);
        }
  
      } catch (error) {
        console.error("❌ Error fetching orders:", error);
        setOrders([]);
      } finally {
        setLoading(false);
      }
    };
  
    fetchOrders(); // ✅ call inside
  }, []); // ✅ end of useEffect
}  
