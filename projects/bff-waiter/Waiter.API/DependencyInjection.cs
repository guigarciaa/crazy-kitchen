using SampleCrud.Application.Services;
using SampleCrud.Data.Repositories;
using SampleCrud.Domain.Repositories;
using SampleCrud.Domain.Services;

namespace SampleCrud.Infra.Injector
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDbInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            // Repositories
            services.AddScoped<IPersonRepository, PersonRepository>();
            // Services
            services.AddScoped<IPersonService, PersonService>();

            return services;
        }
    }
}