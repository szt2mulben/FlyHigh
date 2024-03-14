using System;
using System.Security.Cryptography;

namespace FlyHighApi.Service
{
    public class JwtKeyGenerator
    {
        public static string GenerateJwtKey()
        {
            byte[] keyBytes = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(keyBytes);
            }

            string jwtKey = Convert.ToBase64String(keyBytes);

            return jwtKey;
        }
    }
}
