package com.bookstore.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bookstore.entity.CartItems;

public class CartItemDAO extends JpaDAO<CartItems> implements GenericDAO<CartItems> {

	@Override
	public CartItems create(CartItems cartItem) {
		return super.create(cartItem);
	}
	
	@Override
	public CartItems update(CartItems cartItem) {
		return super.update(cartItem);
	}
	
	@Override
	public CartItems get(Object cartItemId) {
		return super.find(CartItems.class, cartItemId);
	}

	@Override
	public void delete(Object cartItemId) {
		super.delete(CartItems.class, cartItemId);
	}

	@Override
	public List<CartItems> listAll() {
		return super.findWithNamedQuery("CartItem.findAll");
	}

	@Override
	public long count() {
		return super.countWithNamedQuery("CartItem.countBooks");
	}
	
	public List<CartItems> findByCustomer(Integer customerId) {
		return super.findWithNamedQuery("CartItem.findByCustomer", "customerId", customerId);
	}
	
	public boolean checkBook(Integer bookId, Integer customerId) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("bookId", bookId);
		parameters.put("customerId", customerId);
		
		List<CartItems> listItems = super.findWithNamedQuery("CartItem.checkBook", parameters);
		
		if(listItems.size() == 1) {
			return true;
		}
		
		return false;
	}
	
	public List<CartItems> findByBookAndCustomer(Integer bookId, Integer customerId) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("bookId", bookId);
		parameters.put("customerId", customerId);
		
		return super.findWithNamedQuery("CartItem.checkBook", parameters);
	}

}
