import logo from './logo.svg';
import './App.css';
import { useEffect, useState } from 'react';

function App() {
  const [data, setData] = useState([]);
useEffect(() => {
  (async()=> {
    const res = await (await fetch("/services/k8stemplatesme/api/template-attribute/fedd1b27-2c58-4ded-b39f-f28a4e7739ea.aladin.pellcop.com")).json();
   setData(res);
  })()
}, [])
  return (
    <div className="App">

       {
        data.map(item => {
          return (
            <div>
              <p>{item.domain}</p>
              <p>{item.key}</p>
              <img src={item.value} />
            </div>
          )
        })
       }
    </div>
  );
}

export default App;
