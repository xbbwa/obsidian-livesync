// server.js
import express from 'express';
import multer from 'multer';
import fs from 'fs';
import path from 'path';

const app = express();
const PORT = process.env.PORT || 8080;

// 创建 uploads 文件夹（如不存在）
const uploadDir = path.resolve('./uploads');
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir);

// 设置文件上传中间件
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    // 使用上传时的原始文件名
    cb(null, file.originalname);
  }
});
const upload = multer({ storage });

// 中间件：解析 JSON
app.use(express.json());

// ✅ 健康检查
app.get('/', (req, res) => {
  res.send('✅ Obsidian LiveSync Server is running.');
});

// ✅ 上传文件（单个或多个）
app.post('/upload', upload.array('files'), (req, res) => {
  res.json({
    message: '✅ 文件上传成功',
    files: req.files.map(f => f.originalname)
  });
});

// ✅ 下载指定文件
app.get('/file/:filename', (req, res) => {
  const filePath = path.join(uploadDir, req.params.filename);
  if (fs.existsSync(filePath)) {
    res.download(filePath);
  } else {
    res.status(404).json({ error: '找不到文件' });
  }
});

// ✅ 获取当前文件列表
app.get('/files', (req, res) => {
  const files = fs.readdirSync(uploadDir);
  res.json({ files });
});

app.listen(PORT, () => {
  console.log(`✅ Server listening on http://localhost:${PORT}`);
});
