using MySql.Data.MySqlClient;

using System.Data;

namespace BackEnd_ArtePuebla.Functions
{
    public class SQL_User
    {
        string cadenaSQL = ""; //Cadena en proceso...
        public bool ValidUser(string email, string pass)
        {
            try
            {
                using MySqlConnection conn = new(cadenaSQL);
                conn.Open();
                using MySqlCommand cmd = new()
                {
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                    CommandText = "LoginUser"
                };
                cmd.Parameters.AddWithValue("email", email);
                cmd.Parameters.AddWithValue("pass", pass);
                string? exist = cmd.ExecuteScalar().ToString();
                return !string.IsNullOrWhiteSpace(exist);
            }
            catch ( Exception ex )
            {
                Console.WriteLine($"Error en el metodo ValidUser {ex}");
                return false;
            }
        }
    }
}
