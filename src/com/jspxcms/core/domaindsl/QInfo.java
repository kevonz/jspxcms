package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.jspxcms.core.domain.Info;
import com.jspxcms.core.domain.InfoAttribute;
import com.jspxcms.core.domain.InfoBuffer;
import com.jspxcms.core.domain.InfoFile;
import com.jspxcms.core.domain.InfoImage;
import com.jspxcms.core.domain.Node;
import com.jspxcms.core.domain.Special;
import com.jspxcms.core.domain.Tag;
import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;

import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QInfo is a Querydsl query type for Info
 */

public class QInfo extends EntityPathBase<Info> {

    private static final long serialVersionUID = 719493196;

    private static final PathInits INITS = PathInits.DIRECT;

    public static final QInfo info = new QInfo("info");

    public final SetPath<InfoBuffer, QInfoBuffer> buffers = this.<InfoBuffer, QInfoBuffer>createSet("buffers", InfoBuffer.class, QInfoBuffer.class, PathInits.DIRECT);

    public final MapPath<String, String, StringPath> clobs = this.<String, String, StringPath>createMap("clobs", String.class, String.class, StringPath.class);

    public final NumberPath<Integer> comments = createNumber("comments", Integer.class);

    public final QUser creator;

    public final MapPath<String, String, StringPath> customs = this.<String, String, StringPath>createMap("customs", String.class, String.class, StringPath.class);

    public final QInfoDetail detail;

    public final NumberPath<Integer> downloads = createNumber("downloads", Integer.class);

    public final ListPath<InfoFile, QInfoFile> files = this.<InfoFile, QInfoFile>createList("files", InfoFile.class, QInfoFile.class, PathInits.DIRECT);

    public final NumberPath<Integer> id = createNumber("id", Integer.class);

    public final ListPath<InfoImage, QInfoImage> images = this.<InfoImage, QInfoImage>createList("images", InfoImage.class, QInfoImage.class, PathInits.DIRECT);

    public final SetPath<InfoAttribute, QInfoAttribute> infoAttrs = this.<InfoAttribute, QInfoAttribute>createSet("infoAttrs", InfoAttribute.class, QInfoAttribute.class, PathInits.DIRECT);

    public final QNode node;

    public final ListPath<Node, QNode> nodes = this.<Node, QNode>createList("nodes", Node.class, QNode.class, PathInits.DIRECT);

    public final NumberPath<Byte> p1 = createNumber("p1", Byte.class);

    public final NumberPath<Byte> p2 = createNumber("p2", Byte.class);

    public final NumberPath<Byte> p3 = createNumber("p3", Byte.class);

    public final NumberPath<Byte> p4 = createNumber("p4", Byte.class);

    public final NumberPath<Byte> p5 = createNumber("p5", Byte.class);

    public final NumberPath<Byte> p6 = createNumber("p6", Byte.class);

    public final NumberPath<Integer> priority = createNumber("priority", Integer.class);

    public final DateTimePath<java.util.Date> publishDate = createDateTime("publishDate", java.util.Date.class);

    public final QSite site;

    public final ListPath<Special, QSpecial> specials = this.<Special, QSpecial>createList("specials", Special.class, QSpecial.class, PathInits.DIRECT);

    public final StringPath status = createString("status");

    public final ListPath<Tag, QTag> tags = this.<Tag, QTag>createList("tags", Tag.class, QTag.class, PathInits.DIRECT);

    public final NumberPath<Integer> views = createNumber("views", Integer.class);

    public final BooleanPath withImage = createBoolean("withImage");

    public QInfo(String variable) {
        this(Info.class, forVariable(variable), INITS);
    }

    @SuppressWarnings("all")
    public QInfo(Path<? extends Info> path) {
        this((Class)path.getType(), path.getMetadata(), path.getMetadata().isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QInfo(PathMetadata<?> metadata) {
        this(metadata, metadata.isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QInfo(PathMetadata<?> metadata, PathInits inits) {
        this(Info.class, metadata, inits);
    }

    public QInfo(Class<? extends Info> type, PathMetadata<?> metadata, PathInits inits) {
        super(type, metadata, inits);
        this.creator = inits.isInitialized("creator") ? new QUser(forProperty("creator"), inits.get("creator")) : null;
        this.detail = inits.isInitialized("detail") ? new QInfoDetail(forProperty("detail"), inits.get("detail")) : null;
        this.node = inits.isInitialized("node") ? new QNode(forProperty("node"), inits.get("node")) : null;
        this.site = inits.isInitialized("site") ? new QSite(forProperty("site"), inits.get("site")) : null;
    }

}

