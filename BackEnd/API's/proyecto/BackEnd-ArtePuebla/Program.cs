using BackEnd_ArtePuebla.Functions;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if ( app.Environment.IsDevelopment() )
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

//API de inicio de sesion
app.MapGet("/GetValidUser/{email}/{pass}", (string email, string pass) =>
{
    bool exist = new SQL_User().ValidUser(email, pass);
    return Results.Ok(exist);
});


app.Run();
