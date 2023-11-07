const { Kafka } = require('kafkajs')


const kafka = new Kafka({
    clientId: 'producer-de-prueba-en-node',
    brokers: ['localhost:29092'],
})



const producer = kafka.producer();

const sender =  async(value)  => {
    await producer.connect()
    let r = await producer.send({
        topic: 'prueba2',
        messages: [
            { value: 'Hello KafkaJS user! ' + value },
        ],
    });

    console.log('mensaje enviado como ',r);

    await producer.disconnect()
}



let counter = 0;


setInterval(() => sender(counter++), 100);