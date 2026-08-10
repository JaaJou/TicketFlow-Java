package com.jaajou.ticketflow.repository.implementation;

import com.jaajou.ticketflow.entity.UserRole;
import com.jaajou.ticketflow.entity.UserRoleId;
import com.jaajou.ticketflow.repository.UserRoleRepository;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class UserRoleRepositoryImpl implements UserRoleRepository {

    private final EntityManager entityManager;

    @Override
    public UserRole save(UserRole userRole) {
        entityManager.persist(userRole);
        return userRole;
    }

    @Override
    public Optional<UserRole> findById(UserRoleId id) {
        return Optional.ofNullable(entityManager.find(UserRole.class, id));
    }

    @Override
    public List<UserRole> findByUserId(long userId) {
        return entityManager.createQuery(
                        "SELECT ur FROM UserRole ur WHERE ur.user.id = :userId", UserRole.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public void deleteById(UserRoleId id) {
        Optional.ofNullable(entityManager.find(UserRole.class, id)).ifPresent(entityManager::remove);
    }
}
