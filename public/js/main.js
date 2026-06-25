// Small client-side script - kept minimal on purpose.

// Auto-dismiss flash alerts after 4s.
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.alert.alert-dismissible').forEach(el => {
    setTimeout(() => {
      try { bootstrap.Alert.getOrCreateInstance(el).close(); } catch (e) {}
    }, 4000);
  });
});
