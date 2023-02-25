import {useState} from "react";
import Head from "next/head"
import styles from "../styles/Home.module.css"
import axios from "axios";
import type {NextPage} from 'next'

const Home: NextPage = () => {
  let [name, setName] = useState("Dummy")
  const asyncFn = async () => {
    await axios.get("http://127.0.0.1:80/name").then(res => {
      setName(res.data);
    })
  }
  asyncFn()

  return (
    <div className={styles.container}>
      <Head>
        <title>ss49919201</title>
      </Head>
      <main className={styles.main}>
        <h1 className={styles.title}>Welcome!!!{name}</h1>
      </main>
      <footer className={styles.footer}>
        ©︎2023 ss49919201
      </footer>
    </div>
  );
};

export default Home;
