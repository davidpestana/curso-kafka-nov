const { Kafka } = require('kafkajs')
const { SchemaRegistry, SchemaType } = require('@kafkajs/confluent-schema-registry')


const kafka = new Kafka({
    clientId: 'producer-1',
    brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092', 'broker4:9092'],
})

const registry = new SchemaRegistry({host: 'http://schema-registry:8081'});

// const schema = {
//     "type": "record",
//     "name": "RandomTest",
//     "namespace": "examples",
//     "fields": [
//         { "type": "string", "name": "fullName" }
//     ]
//   };

  const schema = `
  {
    "type": "record",
    "name": "RandomTest",
    "namespace": "examples",
    "fields": [{ "type": "string", "name": "fullName" }]
  }
`

const register = async() => {
    const { id } = await registry.register({
        type: SchemaType.AVRO,
        schema
    });
    return id;
}

// const encode = async (id, payload) =>  {
//     return registry.encode(id, payload);
// }

// const payload = { fullName: 'David', age: 46};

register().then(console.log)
//     .then(console.log)
// .then((id) => encode(id, payload))
    // .then(codificado => console.log(codificado));



