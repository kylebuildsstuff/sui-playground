<script lang="ts">
  import { HERO_ID, PACKAGE_ID } from '$lib/shared/shared.constant';
  import {
    devnetWalletAdapter as walletAdapter,
    ConnectButton
  } from '@builders-of-stuff/svelte-sui-wallet-adapter';
  import { Transaction } from '@mysten/sui/transactions';

  const newHero = async () => {
    const tx = new Transaction();

    const [hero] = tx.moveCall({
      target: `${PACKAGE_ID}::contracts::new_hero`,
      arguments: []
    });

    tx.transferObjects([hero], walletAdapter?.currentAccount?.address as any);

    try {
      const { bytes, signature } = await walletAdapter.signTransaction(tx as any, {});

      const executedTx = await walletAdapter.executeTransaction({ bytes, signature });

      console.log('executedTx: ', executedTx);

      return executedTx;
    } catch (error) {
      console.log(error);
    }
  };

  const addSwordsman = async () => {
    const tx = new Transaction();

    tx.moveCall({
      target: `${PACKAGE_ID}::contracts::add_swordsman`,
      arguments: [tx.object(HERO_ID)]
    });

    try {
      const { bytes, signature } = await walletAdapter.signTransaction(tx as any, {});

      const executedTx = await walletAdapter.executeTransaction({ bytes, signature });

      console.log('executedTx: ', executedTx);

      return executedTx;
    } catch (error) {
      console.log(error);
    }
  };

  const getArmy = async () => {
    const tx = new Transaction();

    tx.moveCall({
      target: `${PACKAGE_ID}::contracts::army`,
      arguments: [tx.object(HERO_ID)]
    });

    try {
      const { bytes, signature } = await walletAdapter.signTransaction(tx as any, {});

      const executedTx = await walletAdapter.executeTransaction({ bytes, signature });

      console.log('executedTx: ', executedTx);

      return executedTx;
    } catch (error) {
      console.log(error);
    }
  };

  const getLevel = async () => {
    const tx = new Transaction();

    tx.moveCall({
      target: `${PACKAGE_ID}::contracts::level`,
      arguments: [tx.object(HERO_ID)]
    });

    try {
      const { bytes, signature } = await walletAdapter.signTransaction(tx as any, {});

      const executedTx = await walletAdapter.executeTransaction({ bytes, signature });

      console.log('executedTx: ', executedTx);

      return executedTx;
    } catch (error) {
      console.log(error);
    }
  };

  const getSomeVector = async () => {
    const tx = new Transaction();

    tx.moveCall({
      target: `${PACKAGE_ID}::contracts::some_vector`,
      arguments: []
    });

    try {
      const { bytes, signature } = await walletAdapter.signTransaction(tx as any, {});

      const executedTx = await walletAdapter.executeTransaction({ bytes, signature });

      console.log('executedTx: ', executedTx);

      return executedTx;
    } catch (error) {
      console.log(error);
    }
  };
</script>

<h1>Welcome to SvelteKit</h1>

<ConnectButton {walletAdapter} />
<button onclick={newHero}> New hero </button>
<button onclick={addSwordsman}> Add swordsman </button>
<button onclick={getArmy}> Get army </button>
<button onclick={getLevel}> Get level </button>
<button onclick={getSomeVector}> Get some vector </button>
