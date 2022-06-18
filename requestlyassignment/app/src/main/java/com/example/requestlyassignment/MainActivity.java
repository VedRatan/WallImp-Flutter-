package com.example.requestlyassignment;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;

import io.requestly.rqinterceptor.api.RQCollector;
import io.requestly.rqinterceptor.api.RQInterceptor;
import okhttp3.OkHttpClient;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {
    private RecyclerView mEarthquakeRecyclerView;
    private RecyclerView.LayoutManager earthquakeLayoutManager;
    private EarthquakeAdapter earthquakeAdapter;
    FloatingActionButton refresh;
    TextView emptyText;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mEarthquakeRecyclerView = findViewById(R.id.earthquakeRecyclerView);
        refresh = findViewById(R.id.reload);
        emptyText = findViewById(R.id.emptyAlert);
        mEarthquakeRecyclerView.setHasFixedSize(true);
        mEarthquakeRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        emptyText.setVisibility(View.GONE);


        fetchData();

        refresh.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fetchData();
            }
        });


    }

    void fetchData()
    {
        RQCollector collector = new RQCollector(this, "QvMG8VOiR4ehyKWJIBTL");
        RQInterceptor rqInterceptor = new RQInterceptor.Builder(this).collector(collector).build();
        OkHttpClient client = new OkHttpClient.Builder().addInterceptor(rqInterceptor).build();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://global-earthquake-watch.p.rapidapi.com")
                .addConverterFactory(GsonConverterFactory.create())
                .client(client) // okHttpClient with RQInterceptor
                .build();

        JSONplaceholder jsoNplaceholder = retrofit.create(JSONplaceholder.class);
        Call<List<Earthquake>> call = jsoNplaceholder.getData();
        call.enqueue(new Callback<List<Earthquake>>() {
            @Override
            public void onResponse(Call<List<Earthquake>> call, Response<List<Earthquake>> response) {
                if(!response.isSuccessful())
                {
                    Toast.makeText(MainActivity.this, ""+response.code(), Toast.LENGTH_SHORT).show();
                    return;
                }
                List <Earthquake> earthquakeList = response.body();
                EarthquakeAdapter earthquakeAdapter = new EarthquakeAdapter(earthquakeList, MainActivity.this);

                if(earthquakeList.isEmpty())
                {
                    mEarthquakeRecyclerView.setVisibility(View.GONE);
                    emptyText.setVisibility(View.VISIBLE);
                }
                else
                {
                    mEarthquakeRecyclerView.setVisibility(View.VISIBLE);
                    emptyText.setVisibility(View.GONE);
                    mEarthquakeRecyclerView.setAdapter(earthquakeAdapter);
                }
            }

            @Override
            public void onFailure(Call<List<Earthquake>> call, Throwable t) {

            }
        });
    }
}