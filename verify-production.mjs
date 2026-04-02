import { createClient } from '@supabase/supabase-js';

// No need for dotenv here when running with --env-file
const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Missing Supabase credentials in environment!');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function verifyConnection() {
  console.log(`🔍 Connecting to: ${supabaseUrl}`);
  
  const { data, count, error } = await supabase
    .from('hierarchy_nodes')
    .select('*', { count: 'exact', head: true });

  if (error) {
    console.error('❌ Error connecting to hierarchy_nodes:', error.message);
  } else {
    console.log(`✅ Success! Found ${count} nodes in the hierarchy.`);
  }

  const { data: users, count: userCount, error: userError } = await supabase
    .from('app_users')
    .select('*', { count: 'exact', head: true });

  if (userError) {
    console.error('❌ Error connecting to app_users:', userError.message);
  } else {
    console.log(`✅ Success! Found ${userCount} users.`);
  }
}

verifyConnection();
