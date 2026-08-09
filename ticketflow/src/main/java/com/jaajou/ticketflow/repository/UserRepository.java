package com.jaajou.ticketflow.repository;

import java.util.Collection;
import com.jaajou.ticketflow.entity.User;

public interface UserRepository<T extends User> {
    /*Basic CRUD Operations*/
    T create(T data);
    Collection<T> list(int page, int pageSize);
    T get(Long id);
    T update(T data);
    void delete(T data);
    Boolean delete (Long id);

    /*More complex Operations */
}
