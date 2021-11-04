
using MassTransit;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System.Collections.Generic;
using System.Reflection;
using VideoCommunication.API.Hubs;

namespace VideoCommunication.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddCors(o => o.AddPolicy("CorsPolicy", builder => {
            builder.SetIsOriginAllowed(_ => true)
           .AllowAnyMethod()
           .AllowAnyHeader()
           .AllowCredentials();
        }));

            services.AddMvc(option => option.EnableEndpointRouting = false);

            services.AddSignalR();
            services.AddSingleton<HubController>();
            // MassTransit-RabbitMQ Configuration 
            //services.AddMassTransit(config =>
            //{

            //    config.AddConsumer<CheckeLoggedConsumer>();

            //    config.UsingRabbitMq((ctx, cfg) =>
            //    {
            //        cfg.Host(Configuration["EventBusSettings:HostAddress"]);

            //        cfg.ReceiveEndpoint(EventBusConstants.LoginCheckQueue, c =>
            //        {
            //            c.ConfigureConsumer<CheckeLoggedConsumer>(ctx);
            //        });
            //    });
            //});
            //services.AddMassTransitHostedService();

            services.AddSingleton<List<User>>();
            services.AddSingleton<List<UserCall>>();
            services.AddSingleton<List<CallOffer>>();

            services.AddAutoMapper(typeof(Startup));
         //   services.AddScoped<CheckeLoggedConsumer>();

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "VideoCommunication.API", Version = "v1" });
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "VideoCommunication.API v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors("CorsPolicy");

            app.UseMvc();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapHub<HubController>("/ConnectionHub", options =>
                {
                    options.Transports = Microsoft.AspNetCore.Http.Connections.HttpTransportType.WebSockets;
                });
            });
        }
    }
}
