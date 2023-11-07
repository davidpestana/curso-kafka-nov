const { Kafka } = require('kafkajs')


const kafka = new Kafka({
    clientId: 'producer-de-prueba-en-node',
    brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})



const producer = kafka.producer();
const consumer = kafka.consumer();


const sender =  async(value)  => {
    await producer.connect()
    let r = await producer.send({
        topic: 'prueba2',
        messages: [
            { partition: 1, value: 'Hello KafkaJS user! ' + value },
            { partition: 2, value: 'Hello KafkaJS user! ' + value },
            { partition: 3, value: 'Hello KafkaJS user! ' + value },
        ],
    });

    console.log('mensaje enviado como ',r);

    await producer.disconnect()
}



let counter = 0;


setInterval(() => sender(counter++), 100);