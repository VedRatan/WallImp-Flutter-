package com.example.requestlyassignment;


public class Earthquake {
    private String date;
    private String time;
    private String magnitude;
    private String location;

    public Earthquake(String date, String time, String magnitude, String location) {
        this.date = date;
        this.time = time;
        this.magnitude = magnitude;
        this.location = location;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public String getMagnitude() {
        return magnitude;
    }

    public String getLocation() {
        return location;
    }


    public void setDate(String date) {
        this.date = date;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setMagnitude(String magnitude) {
        this.magnitude = magnitude;
    }

    public void setLocation(String location) {
        this.location = location;
    }

}