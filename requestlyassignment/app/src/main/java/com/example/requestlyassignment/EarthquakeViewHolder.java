package com.example.requestlyassignment;

import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class EarthquakeViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener{

    public TextView location;
    public TextView date;
    public TextView time;
    public TextView magnitude;

    public EarthquakeViewHolder(@NonNull View itemView) {
        super(itemView);
        location = itemView.findViewById(R.id.location);
        date = itemView.findViewById(R.id.date);
        time = itemView.findViewById(R.id.time);
        magnitude = itemView.findViewById(R.id.magnitude);
    }

    @Override
    public void onClick(View v) {

    }
}
