package com.benzolamps.dict.service.impl;

import com.benzolamps.dict.service.base.BackupService;
import com.benzolamps.dict.util.DictFile;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.StreamUtils;

import java.io.*;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 数据库备份恢复Service接口实现类
 * @author Benzolamps
 * @version 2.2.1
 * @datetime 2018-10-9 18:49:09
 */
@Service("backupService")
public class BackupServiceImpl implements BackupService {

    @Value("mysql\\data")
    private File path;

    @Override
    public void backup(OutputStream outputStream) throws IOException {
        try (ZipOutputStream zos = DictFile.zip(path, outputStream, "mysql")) {
            zos.putNextEntry(new ZipEntry("start.txt"));
            try (PrintWriter pw = new PrintWriter(zos)) {
                pw.println("delete mysql");
                Path root = new File("").getAbsoluteFile().toPath();
                DictFile.deepListFiles(path, null).forEach(file -> {
                    Path subPath = file.getAbsoluteFile().toPath();
                    pw.println("save " + subPath.subpath(root.getNameCount(), subPath.getNameCount()));
                });
                pw.flush();
            }
        }
    }

    @Override
    @SuppressWarnings("SpellCheckingInspection")
    public void restore(InputStream inputStream) throws IOException {
        File file = new File("tmp/dict/restore" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".zip");

        /* 创建父路径 */
        if (file.getParentFile() != null && !file.getParentFile().exists()) Assert.isTrue(file.getParentFile().mkdirs(), "创建父路径失败");

        /* 创建新文件 */
        Assert.isTrue(file.createNewFile(), "创建新文件失败");

        /* 流复制 */
        try (InputStream is = inputStream; OutputStream os = new FileOutputStream(file)) {
            StreamUtils.copy(is, os);
        }
    }
}