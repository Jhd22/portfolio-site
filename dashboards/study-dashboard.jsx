// Study Dashboard — React Artifact
// 
// This is a placeholder. The actual dashboard will be a Claude artifact
// that reads from Supabase instead of artifact persistent storage.
//
// Source: evolves from Læseplan_Dashboard.jsx
//
// Key changes from current version:
// 1. Replace INITIAL_TEXTS constant with Supabase fetch
// 2. Replace local state toggles with Supabase updates
// 3. Add depth tracking (read → noted → restructured → compared → tested)
// 4. Add priority recalculation based on exam proximity
// 5. Connect to KU schedule from Supabase
//
// Supabase connection:
//   const SUPABASE_URL = 'https://your-project.supabase.co';
//   const SUPABASE_KEY = 'your-anon-key';
//   
//   async function fetchReadings() {
//     const response = await fetch(`${SUPABASE_URL}/rest/v1/readings?order=week,id`, {
//       headers: {
//         'apikey': SUPABASE_KEY,
//         'Authorization': `Bearer ${SUPABASE_KEY}`,
//       }
//     });
//     return response.json();
//   }
//
// See: Læseplan_Dashboard.jsx for current implementation
