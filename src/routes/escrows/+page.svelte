<script lang="ts">
  import {
    devnetWalletAdapter as walletAdapter,
    ConnectButton
  } from '@builders-of-stuff/svelte-sui-wallet-adapter';
</script>

<div class="my-4">
  <a href="/"> Home</a>
  <ConnectButton {walletAdapter} />
</div>
