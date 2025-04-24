import { ItemPreview, MarketplaceFilters, MarketplaceResponse } from '@/types/marketplace';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'https://2kps99nm-8080.uks1.devtunnels.ms';

export const marketplaceApi = {
  async getProducts(filters: MarketplaceFilters): Promise<MarketplaceResponse> {
    try {
      const response = await fetch(`${API_URL}/products?` + new URLSearchParams({
        page: filters.page?.toString() || '1',
        limit: filters.limit?.toString() || '10',
        ...(filters.minPrice !== undefined && { minPrice: filters.minPrice.toString() }),
        ...(filters.maxPrice !== undefined && { maxPrice: filters.maxPrice.toString() }),
        ...(filters.type && { type: filters.type })
      }));

      if (!response.ok) {
        throw new Error('Failed to fetch items');
      }

      const data = await response.json();
      return {
        items: data.map((item: any) => ({
          id: item.id,
          title: item.title,
          price: item.price,
          thumbnailUrl: item.photo,
          rating: item.rating,
          description: item.description,
          category: item.type,
          size: item.size,
          grade: item.grade,
        })),
        total: data.length,
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
      const response = await fetch(`${API_URL}/products/${id}`);

      if (!response.ok) {
        throw new Error('Failed to fetch product');
      }

      const data = await response.json();
      return {
        id: data.id,
        title: data.title,
        price: data.price,
        thumbnailUrl: data.photo,
        rating: data.rating,
        description: data.description,
        category: data.type,
        size: data.size,
        grade: data.grade,
        resellerId: data.sellerId,
        resellerName: data.sellerName,
        status: data.status,
      };
    } catch (error) {
      console.error('Error fetching product:', error);
      throw error;
    }
  },

  async getProductsByReseller(resellerId: string, page: number = 1, limit: number = 10): Promise<ItemPreview[]> {
    try {
      const response = await fetch(`${API_URL}/products/reseller/${resellerId}?` + new URLSearchParams({
        page: page.toString(),
        limit: limit.toString(),
      }));

      if (!response.ok) {
        throw new Error('Failed to fetch reseller products');
      }

      const data = await response.json();
      return data.map((item: any) => ({
        id: item.id,
        title: item.title,
        price: item.price,
        imageUrl: item.photo,
        grade: item.grade,
        size: item.size,
        status: item.status,
        sellerId: item.sellerId,
        rating: item.rating,
        description: item.description,
        type: item.type,
        bundleId: item.bundleId,
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