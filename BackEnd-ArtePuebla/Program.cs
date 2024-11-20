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

// API de inicio de sesi�n
app.MapGet("/GetValidUser/{email}/{pass}", (string email, string pass) =>
{
    if ( string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pass) )
    {
        return Results.BadRequest("Email y contrase�a no pueden estar vac�os.");
    }

    // Llama a tu m�todo para obtener el hash de la contrase�a almacenada
    string storedHashedPassword = new SQL_User().GetHashedPassword(email);
    bool log = new SQL_User().ValidUser(email, storedHashedPassword);

    // Verifica si se obtuvo un hash (esto puede significar que el usuario no existe)
    if ( storedHashedPassword == null )
    {
        return Results.NotFound("Usuario no encontrado.");
    }

    // Verifica si la contrase�a ingresada es v�lida
    bool isValidUser = PasswordHelper.VerifyPassword(pass, storedHashedPassword);

    return Results.Ok(isValidUser);
});

app.MapGet("/GetEvent/{start}/{end}", (string start, string end) =>
{
    return Results.Ok(new SQL_User().ObtenerEvento(start, end));
});

// API para insertar un nuevo usuario
app.MapPost("/InsertUser/{name}/{fLastName}/{sLastName}/{email}/{pass}/{rol}", (string name, string fLastName, string sLastName, string email, string pass, string rol) =>
{
    if ( string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pass) || string.IsNullOrWhiteSpace(name) )
    {
        return Results.BadRequest("Nombre, email y contrase�a son obligatorios.");
    }

    // Valores est�ticos
    string staticIdGoogle = "valorPredeterminado"; // Valor est�tico de ID_GOOGLE

    // Hash de la contrase�a antes de insertarla
    string hashedPassword = PasswordHelper.HashPassword(pass);

    bool success = new SQL_User().InsertUser(name, fLastName, sLastName, email, hashedPassword, rol, staticIdGoogle);

    return Results.Ok(success);
});


app.Run();
