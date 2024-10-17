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
      target: `${PACKAGE_ID}::suiscape::new_hero`,
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
      target: `${PACKAGE_ID}::suiscape::add_swordsman`,
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
      target: `${PACKAGE_ID}::suiscape::army`,
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
      target: `${PACKAGE_ID}::suiscape::level`,
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
      target: `${PACKAGE_ID}::suiscape::some_vector`,
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
      target: `${PACKAGE_ID}::suiscape::battle`,
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

  const match_test = async () => {
    const tx = new Transaction();

    const [thing] = await tx.moveCall({
      target: `${PACKAGE_ID}::suiscape::match_or_not`,
      arguments: [tx.pure.bool(false)]
    });

    tx.transferObjects([thing], walletAdapter?.currentAccount?.address as any);

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

<div class="my-4">
  <ConnectButton {walletAdapter} />
  <!-- <a href="/escrows"> Escrows</a> -->
  <a href="/kiosks">
    <Button variant="outline">Kiosks</Button>
  </a>
</div>

<Button variant="secondary" onclick={newHero}>New hero</Button>
<Button variant="secondary" onclick={addSwordsman}>Add swordsman</Button>
<Button variant="secondary" onclick={getArmy}>Get army</Button>
<Button variant="secondary" onclick={getLevel}>Get level</Button>
<Button variant="secondary" onclick={getSomeVector}>Get some vector</Button>
<Button variant="secondary" onclick={() => getObject(HERO_ID)}>Get hero</Button>
<Button variant="secondary" onclick={battle}>Battle</Button>
<Button variant="secondary" onclick={match_test}>Match</Button>
