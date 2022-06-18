package com.example.requestlyassignment;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class EarthquakeAdapter extends RecyclerView.Adapter <EarthquakeViewHolder>{

    private List<Earthquake> earthquakeList;
    private Context context;

    public EarthquakeAdapter(List<Earthquake> earthquakeList, Context context) {
        this.earthquakeList = earthquakeList;
        this.context = context;
    }

    @NonNull
    @Override
    public EarthquakeViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View layoutView = LayoutInflater.from(parent.getContext()).inflate(R.layout.earthquake_item_layout,null, false);
        EarthquakeViewHolder erv = new EarthquakeViewHolder(layoutView);
        return  erv;
    }

    @Override
    public void onBindViewHolder(@NonNull EarthquakeViewHolder holder, int position) {
        holder.location.setText(earthquakeList.get(position).getLocation());
        holder.date.setText(earthquakeList.get(position).getDate());
        holder.time.setText(earthquakeList.get(position).getTime());
        holder.magnitude.setText(earthquakeList.get(position).getMagnitude());
    }

    @Override
    public int getItemCount() {
        return earthquakeList.size();
    }
}
