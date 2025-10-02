import React from "react";

export default function Leaderboard({ daos }) {
  const sorted = daos.sort((a,b)=>b.successRate - a.successRate);
  return (
    <div style={{textAlign:"center", marginTop:"20px"}}>
      <h3>Top DAOs</h3>
      <ol>
        {sorted.map((d,i)=><li key={i}>{d.name}: {d.successRate} votes</li>)}
      </ol>
    </div>
  );
}
