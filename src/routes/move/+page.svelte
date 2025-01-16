<script lang="ts">
  import {
    testnetWalletAdapter as walletAdapter,
    ConnectButton
  } from '@builders-of-stuff/svelte-sui-wallet-adapter';

  import { Button } from '$lib/components/ui/button';
  import { LISTINGS_TABLE_ID } from '$lib/shared/shared.constant';

  const what = () => {
    console.log('what');
  };

  const getListingsTable = async () => {
    const object = await walletAdapter.suiClient.getObject({
      id: '0x1ca5e019ce0f00bdc3b9c5ee0410aedcaf1848d4d109840928eb7e7455d0bbd6',
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
</script>

<div class="my-4">
  <ConnectButton {walletAdapter} />
  <a href="/">
    <Button variant="outline">Home</Button>
  </a>
</div>

<Button variant="secondary" onclick={getListingsTable}>The table</Button>
