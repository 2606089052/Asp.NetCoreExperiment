﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Swashbuckle.AspNetCore.Swagger;
using Swashbuckle.AspNetCore;
using Microsoft.Extensions.PlatformAbstractions;
using RestfulStandard01.Model;
using System.Text;
using Microsoft.AspNetCore.Mvc.Formatters;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using System.Xml.Linq;
using System.Threading;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Diagnostics;

namespace RestfulStandard01
{
    /// <summary>
    /// 
    /// </summary>
    public class Startup
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="configuration"></param>
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        /// <summary>
        /// 
        /// </summary>
        public IConfiguration Configuration { get; }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="services"></param>
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IAccountRepository, AccountRepository>();
            services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("RestfulStandard01", new Info { Title = "API接口", Version = "v1", Contact = new Contact { Email = "", Name = "NetStars", Url = "" }, Description = "医API" });
                var basePath = PlatformServices.Default.Application.ApplicationBasePath;
                var xmlPath = Path.Combine(basePath, $"RestfulStandard01.xml");
                options.IncludeXmlComments(xmlPath);

                var api = new ApiKeyScheme { In = "header", Description = "请输入带有Bearer的Token", Name = "Authorization", Type = "apiKey" };
                options.AddSecurityDefinition("Bearer", api);
                options.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>> {
                { "Bearer", Enumerable.Empty<string>() },
                });

            });
            services.AddMvc(options =>
            {
                options.ReturnHttpNotAcceptable = true;
                //通过此设置来确定是否启用ViewModel验证
                options.MaxModelValidationErrors = 200;

                options.AllowValidatingTopLevelNodes = false;
            })
            .AddXmlSerializerFormatters() //设置支持XML格式输入输出
            .AddJsonOptions(op => op.SerializerSettings.ContractResolver = new DefaultContractResolver())//大小写不转换
            .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="app"></param>
        /// <param name="Class.csenv"></param>
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {

             env.EnvironmentName = EnvironmentName.Production;
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                //用中间件来处理Action的异常
                //app.Use(async (context, next) =>
                //{
                //    try
                //    {
                //        await next.Invoke();
                //    }
                //    catch (Exception exc)
                //    {
                //        var logger = app.ApplicationServices.GetService(typeof(ILogger<Startup>)) as ILogger;
                //        logger.LogCritical(exc, exc.Message);
                //        var result = "一个错误发生";
                //        var data = Encoding.UTF8.GetBytes(result);
                //        context.Response.StatusCode = 500;
                //        context.Response.ContentType = "application/json";
                //        context.Response.Body.Write(data, 0, data.Length);
                //    }
                //});
                //通过异常处理机制
                app.UseExceptionHandler(builder =>
                {
                    builder.Run(async context =>
                    {
                        var exceptionHandlerFeature = context.Features.Get<IExceptionHandlerFeature>();
                        if (exceptionHandlerFeature != null)
                        {
                            var logger = app.ApplicationServices.GetService(typeof(ILogger<Startup>)) as ILogger;
                            logger.LogError(exceptionHandlerFeature.Error.Message);
                        }
                        var result = "一个错误发生";
                        var data = Encoding.UTF8.GetBytes(result);
                        context.Response.StatusCode = 500;
                        context.Response.ContentType = "application/json";
                        await context.Response.Body.WriteAsync(data, 0, data.Length);
                    });
                });

            }
            app.UseMvc(options =>
            {

            }).UseSwagger(options =>
            {
                options.RouteTemplate = "{documentName}/swagger.json";
            })
                .UseSwaggerUI(options =>
                {
                    options.DocumentTitle = "RestfulStandard01.API";
                    options.SwaggerEndpoint("/RestfulStandard01/swagger.json", "RestfulStandard01");
                }); ;
        }
    }

    public class XDocumentInputFormatter : InputFormatter, IInputFormatter, IApiRequestFormatMetadataProvider
    {
        public XDocumentInputFormatter()
        {
            SupportedMediaTypes.Add("application/xml");
        }

        protected override bool CanReadType(Type type)
        {
            if (type.IsAssignableFrom(typeof(XDocument)))
            {
                return true;
            }
            return base.CanReadType(type);
        }

        public override async Task<InputFormatterResult> ReadRequestBodyAsync(InputFormatterContext context)
        {
            var xmlDoc = await XDocument.LoadAsync(context.HttpContext.Request.Body, LoadOptions.None, CancellationToken.None);
            return InputFormatterResult.Success(xmlDoc);
        }
    }


}
