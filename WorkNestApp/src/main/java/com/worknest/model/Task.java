package com.worknest.model;

public class Task {

    private String title;
    private String description;

    // Default constructor
    public Task() {}

    // Getters and setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Optional: toString()
    @Override
    public String toString() {
        return "Task{title='" + title + "', description='" + description + "'}";
    }
}
