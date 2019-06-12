# -*- mode: python -*-

block_cipher = None


a = Analysis(['hydrus/client.py'],
             pathex=['.'],
             binaries=[],
             datas=[
               ('hydrus/bin/*', 'bin'),
               ('hydrus/help/*', 'help'),
               ('hydrus/static/*', 'static'),
               ('hydrus/include/*.py', 'include'),
               ('hydrus/client.pyw', '.'),
               ('hydrus/client.py', '.'),
               ('hydrus/server.py', '.'),
               ('dist/server/server', '.'),
               ('hydrus/license.txt', '.'),
               ('hydrus/Readme.txt', '.'),
               ('hydrus/help my client will not boot.txt', '.'),
               ('hydrus/db/*', 'db')
             ],
             hiddenimports=['server.py'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          [],
          exclude_binaries=True,
          name='client',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          console=False )
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=False,
               upx=True,
               name='client')