using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace VideoCommunication.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        //public static IHostBuilder CreateHostBuilder(string[] args) =>
        //    Host.CreateDefaultBuilder(args)
        //        .ConfigureWebHostDefaults(webBuilder =>
        //        {
        //            webBuilder.UseStartup<Startup>();
        //        });

        public static IHostBuilder CreateHostBuilder(string[] args) =>
           Host.CreateDefaultBuilder(args)
               .ConfigureWebHostDefaults(webBuilder =>
               {
                   webBuilder.UseKestrel();
                   webBuilder.UseContentRoot(Directory.GetCurrentDirectory());
                   Console.WriteLine("Checking IP...");
                   webBuilder.UseUrls("https://0.0.0.0:5000", "https://odin:5000");
                   Console.WriteLine("Ip Correct");
                   webBuilder.UseIISIntegration();
                   webBuilder.UseStartup<Startup>();

                   Console.Clear();
                   Console.WriteLine("Server started");
               }).UseDefaultServiceProvider(options =>
               options.ValidateScopes = false);
    }
}

