<script lang="ts">
  import { HERO_ID, PACKAGE_ID } from '$lib/shared/shared.constant';
  import {
    devnetWalletAdapter as walletAdapter,
    ConnectButton
  } from '@builders-of-stuff/svelte-sui-wallet-adapter';
  import { Transaction } from '@mysten/sui/transactions';

  import { Button } from '$lib/components/ui/button';

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

  const getObject = async (objectId: string) => {
    const object = await walletAdapter.suiClient.getObject({
      id: objectId,
      options: {
        showContent: true,
        showDisplay: true,
        showType: true,
        showOwner: true
      }
    });

    console.log('object: ', object);
    return object;
  };

  const battle = async () => {
    const tx = new Transaction();

    tx.moveCall({
      target: `${PACKAGE_ID}::contracts::battle`,
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
</script>

<h1>Welcome to SvelteKit</h1>

<ConnectButton {walletAdapter} />
<Button onclick={newHero}>New hero</Button>
<Button onclick={addSwordsman}>Add swordsman</Button>
<Button onclick={getArmy}>Get army</Button>
<Button onclick={getLevel}>Get level</Button>
<Button onclick={getSomeVector}>Get some vector</Button>
<Button onclick={() => getObject(HERO_ID)}>Get object</Button>
<Button onclick={battle}>Battle</Button>
