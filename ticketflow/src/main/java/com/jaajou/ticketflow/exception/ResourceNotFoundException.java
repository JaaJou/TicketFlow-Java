package com.jaajou.ticketflow.exception;

public class ResourceNotFoundException extends RuntimeException{
    public ResourceNotFoundException(String resourceName, Object identifier){
        super(resourceName + " not found with id/name : " + identifier);
    }
}
