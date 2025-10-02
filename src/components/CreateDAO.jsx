import React, { useState } from "react";

export default function CreateDAO({ wallet, createDAOHandler }) {
  const [name, setName] = useState("");
  const [members, setMembers] = useState("");

  const handleCreate = () => {
    const membersArray = members.split(",").map(m=>m.trim());
    createDAOHandler(name, membersArray);
  }

  return (
    <div style={{textAlign:"center", margin:"20px"}}>
      <input type="text" placeholder="DAO Name" value={name} onChange={(e)=>setName(e.target.value)} style={{width:"200px", padding:"5px"}} />
      <input type="text" placeholder="Members (comma-separated)" value={members} onChange={(e)=>setMembers(e.target.value)} style={{width:"300px", padding:"5px", marginLeft:"10px"}} />
      <button onClick={handleCreate} style={{marginLeft:"10px", padding:"5px 10px"}}>Create DAO</button>
    </div>
  );
}
