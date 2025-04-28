import { ItemPreview, MarketplaceFilters, MarketplaceResponse } from '@/types/marketplace';

const API_URL = process.env.NEXT_PUBLIC_API_URL;


export const marketplaceApi = {
  async getProducts(filters: MarketplaceFilters): Promise<MarketplaceResponse> {
    try {
      const queryParams = new URLSearchParams({
        page: filters.page?.toString() || '1',
        limit: filters.limit?.toString() || '10',
        minPrice: filters.minPrice?.toString() || '0',
        maxPrice: filters.maxPrice?.toString() || '1000',
        type: filters.type || '',
        size: filters.size?.join(',') || '',
        grade: filters.grade?.join(',') || '',
        search: filters.search || ''
      });
      const token = localStorage.getItem('token');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`${API_URL}/products?${queryParams}`, {
        headers: {
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => null);
        console.error('Server response:', {
          status: response.status,
          statusText: response.statusText,
          error: errorData
        });
        throw new Error(errorData?.error || 'Failed to fetch items');
      }

      const data = await response.json();
      // Handle direct array response from backend
      const products = Array.isArray(data) ? data : [];


      const mappedItems = products.map((item: any) => {
        const imageUrl = item.image_url;

        return {
          id: item.id || item._id,
          title: item.title,
          price: item.price,
          thumbnailUrl: item.image_url,
          rating: item.rating || 0,
          description: item.description || '',
          category: item.type || 'Unknown',
          size: item.size || '',
          grade: item.grade || '',
          resellerId: item.reseller_id || item.sellerId,
          resellerName: item.sellerName || 'Unknown Seller',
          status: item.status || 'available'
        };
      });

      return {
        items: mappedItems,
        total: mappedItems.length,
        page: filters.page || 1,
        limit: filters.limit || 10
      };
    } catch (error) {
      console.error('Error fetching marketplace items:', error);
      throw error;
    }
  },

  async getProductById(id: string): Promise<ItemPreview> {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`${API_URL}/products/${id}`, {
        headers: {
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch product');
      }

      const data = await response.json();
      return {
        id: data.id || data._id,
        title: data.title,
        price: data.price,
        thumbnailUrl: data.image_url,
        rating: data.rating || 0,
        description: data.description || '',
        category: data.type || 'Unknown',
        size: data.size || '',
        grade: data.grade || '',
        resellerId: data.sellerId || data.resellerId,
        resellerName: data.sellerName || 'Unknown Seller',
        status: data.status || 'available'
      };
    } catch (error) {
      console.error('Error fetching product:', error);
      throw error;
    }
  },

  async getProductsByReseller(resellerId: string, page: number = 1, limit: number = 10): Promise<ItemPreview[]> {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        throw new Error('Authentication required');
      }

      const response = await fetch(`${API_URL}/products/reseller/${resellerId}?` + new URLSearchParams({
        page: page.toString(),
        limit: limit.toString(),
      }), {
        headers: {
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch reseller products');
      }

      const data = await response.json();
      return data.map((item: any) => ({
        id: item.id || item._id,
        title: item.title,
        price: item.price,
        thumbnailUrl: item.image_url,
        rating: item.rating || 0,
        description: item.description || '',
        category: item.type || 'Unknown',
        size: item.size || '',
        grade: item.grade || '',
        resellerId: item.sellerId || item.resellerId,
        resellerName: item.sellerName || 'Unknown Seller',
        status: item.status || 'available'
      }));
    } catch (error) {
      console.error('Error fetching reseller products:', error);
      throw error;
    }
  },

  async createProduct(product: Omit<ItemPreview, 'id'>): Promise<ItemPreview> {
    try {
      const response = await fetch(`${API_URL}/products`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify(product),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error || 'Failed to create product');
      }

      const data = await response.json();
      return data.data;
    } catch (error) {
      console.error('Error creating product:', error);
      throw error;
    }
  },

  async updateProduct(id: string, updates: Partial<ItemPreview>): Promise<void> {
    try {
      const response = await fetch(`${API_URL}/products/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify(updates),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error || 'Failed to update product');
      }
    } catch (error) {
      console.error('Error updating product:', error);
      throw error;
    }
  },

  async deleteProduct(id: string): Promise<void> {
    try {
      const response = await fetch(`${API_URL}/products/${id}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error || 'Failed to delete product');
      }
    } catch (error) {
      console.error('Error deleting product:', error);
      throw error;
    }
  },
};

export async function getUserById(id: string) {
  const token = localStorage.getItem('token');
  const res = await fetch(`${API_URL}/admin/users`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Accept': 'application/json',
    },
  });
  if (!res.ok) throw new Error('Failed to fetch users');
  const users = await res.json();
  if (Array.isArray(users)) {
    return users.find((u: any) => u.id === id);
  }
  return users;
} 