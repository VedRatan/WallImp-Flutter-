package com.example.requestlyassignment;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

public interface JSONplaceholder {

   @GET("/week?rapidapi-key=023ca670b8mshbdc94ff54f1a45bp179e4ejsn2c0b82084e07")
   Call<List<Earthquake>> getData();

}
