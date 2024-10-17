<script lang="ts">
  import {
    devnetWalletAdapter as walletAdapter,
    ConnectButton
  } from '@builders-of-stuff/svelte-sui-wallet-adapter';

  import { Button } from '$lib/components/ui/button';
</script>

<div class="my-4">
  <ConnectButton {walletAdapter} />
  <a href="/">
    <Button variant="outline">Home</Button>
  </a>
</div>
