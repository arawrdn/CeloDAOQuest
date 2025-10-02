import React, { useState } from "react";

export default function QuestVoting({ quest, voteHandler }) {
  return (
    <div style={{textAlign:"center", margin:"20px"}}>
      <p>{quest.description}</p>
      <button onClick={()=>voteHandler(true)} style={{marginRight:"10px"}}>Vote Success</button>
      <button onClick={()=>voteHandler(false)}>Vote Fail</button>
    </div>
  );
}
