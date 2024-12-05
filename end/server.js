const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

// Initialisation de l'application
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connexion à MongoDB
mongoose.connect(
    'mongodb+srv://jean:123@cluster0.i28ak.mongodb.net/learn?retryWrites=true&w=majority&appName=Cluster0',
    
);

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'Erreur de connexion à MongoDB:'));
db.once('open', () => {
    console.log('Connecté à MongoDB');
});

// Définir le modèle pour la collection
const formSchema = new mongoose.Schema({
    email: { type: String, required: true },
    name: { type: String, required: true },
});

const FormModel = mongoose.model('User', formSchema);

// Routes CRUD

// 1. Créer un enregistrement
app.post('/api/users', async (req, res) => {
    try {
        const { email, name } = req.body;
        const user = new FormModel({ email, name });
        await user.save();
        res.status(201).json(user);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// 2. Lire tous les enregistrements
app.get('/api/users', async (req, res) => {
    try {
        const users = await FormModel.find();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// 3. Lire un enregistrement par ID
app.get('/api/users/:id', async (req, res) => {
    try {
        const user = await FormModel.findById(req.params.id);
        if (!user) {
            return res.status(404).json({ error: 'Enregistrement non trouvé' });
        }
        res.status(200).json(user);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// 4. Mettre à jour un enregistrement
app.put('/api/users/:id', async (req, res) => {
    try {
        const { email, name } = req.body;
        const user = await FormModel.findByIdAndUpdate(
            req.params.id,
            { email, name },
            { new: true, runValidators: true }
        );
        if (!user) {
            return res.status(404).json({ error: 'Enregistrement non trouvé' });
        }
        res.status(200).json(user);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// 5. Supprimer un enregistrement
app.delete('/api/users/:id', async (req, res) => {
    try {
        const user = await FormModel.findByIdAndDelete(req.params.id);
        if (!user) {
            return res.status(404).json({ error: 'Enregistrement non trouvé' });
        }
        res.status(200).json({ message: 'Enregistrement supprimé avec succès' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Démarrer le serveur
const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Serveur en cours d'exécution sur http://localhost:${PORT}`);
});
