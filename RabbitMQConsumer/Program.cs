using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RabbitMQConsumer;
using System.Text;
var factory = new ConnectionFactory
{
    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq",
    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
};
factory.ClientProvidedName = "Rabbit Test Consumer";
IConnection connection = factory.CreateConnection();
IModel channel = connection.CreateModel();

string exchangeName = "EmailExchange";
string routingKey = "email_queue";
string queueName = "EmailQueue";

channel.ExchangeDeclare(exchangeName, ExchangeType.Direct);
channel.QueueDeclare(queueName, true, false, false, null);
channel.QueueBind(queueName, exchangeName, routingKey, null);

var consumer = new EventingBasicConsumer(channel);

consumer.Received += (sender, args) =>
{
    //Task.Delay(TimeSpan.FromSeconds(2)).Wait();
    var body = args.Body.ToArray();
    string message = Encoding.UTF8.GetString(body);

    Console.WriteLine($"Message received: {message}");
    EmailService emailService = new EmailService();
    emailService.SendEmail(message);

    channel.BasicAck(args.DeliveryTag, false);
};

channel.BasicConsume(queueName, false, consumer);

Console.WriteLine("Waiting for messages. Press Q to quit.");

// Sleep for a long time to keep the application running
Thread.Sleep(Timeout.Infinite);

// Close resources before exiting
channel.Close();
connection.Close();

/*Console.WriteLine("Waiting for messages. Press Q to quit.");

while (true)
{
    // Add a delay to avoid a tight loop
    Thread.Sleep(1000);

    if (Console.KeyAvailable && Console.ReadKey(intercept: true).Key == ConsoleKey.Q)
    {
        break; // Break the loop if 'Q' is pressed
    }
}

// Close resources before exiting
channel.Close();
connection.Close();*/